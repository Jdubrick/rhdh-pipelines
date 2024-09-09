#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Default values
default_config_file="${SCRIPT_DIR}/build-config.env"

# Load build credentials and configuration
CONFIG_FILE="${CONFIG_FILE:-$default_config_file}"
if [ ! -f "${CONFIG_FILE}" ]; then
  echo "$SCRIPT_DIR/build-config.env does not exists. Look at instructions in $SCRIPT_DIR/build-config-template.env"
  exit 1
fi

# shellcheck source=/dev/null
source "${CONFIG_FILE}"

NAMESPACE=$(oc config view --minify -o 'jsonpath={..namespace}')

function cleanNamespace() {
    oc delete serviceaccount ai-rhdh-pipeline
    oc delete secret docker-push-secret
    oc delete rolebinding ai-rhdh-pipelines-runner
}

function provisionNamespace() {
    oc create serviceaccount ai-rhdh-pipeline

    oc create secret docker-registry docker-push-secret \
      --docker-server="${IMAGE_REPOSITORY}" --docker-username="${DOCKER_USERNAME}" --docker-password="${DOCKER_PASSWORD}"
    oc secret link ai-rhdh-pipeline docker-push-secret
    oc secret link ai-rhdh-pipeline docker-push-secret --for=pull,mount

    oc create rolebinding ai-rhdh-pipelines-runner --clusterrole=ai-rhdh-pipelines-runner --serviceaccount="${NAMESPACE}":ai-rhdh-pipeline
}

function cleanCluster() {
  oc delete securitycontextconstraint ai-rhdh-pipelines-scc
  oc delete clusterrole ai-rhdh-pipelines-runner
}

function provisionCluster() {
  cat <<EOF | oc apply -f -
    apiVersion: security.openshift.io/v1
    kind: SecurityContextConstraints
    metadata:
      name: ai-rhdh-pipelines-scc
    allowHostDirVolumePlugin: false
    allowHostIPC: false
    allowHostNetwork: false
    allowHostPID: false
    allowHostPorts: false
    allowPrivilegeEscalation: false
    allowPrivilegedContainer: false
    allowedCapabilities:
      - SETFCAP
    defaultAddCapabilities: null
    fsGroup:
      type: MustRunAs
    groups:
      - system:cluster-admins
    priority: 10
    readOnlyRootFilesystem: false
    requiredDropCapabilities:
      - MKNOD
    runAsUser:
      type: RunAsAny
    seLinuxContext:
      type: MustRunAs
    supplementalGroups:
      type: RunAsAny
    users: []
    volumes:
      - configMap
      - downwardAPI
      - emptyDir
      - persistentVolumeClaim
      - projected
      - secret
EOF

  cat <<EOF | oc apply -f -
    apiVersion: rbac.authorization.k8s.io/v1
    kind: ClusterRole
    metadata:
      name: ai-rhdh-pipelines-runner
    rules:
    - apiGroups:
        - tekton.dev
      resources:
        - pipelineruns
      verbs:
        - get
    - apiGroups:
        - tekton.dev
      resources:
        - taskruns
      verbs:
        - get
        - list
        - patch
    - apiGroups:
        - ""
      resources:
        - secrets
      verbs:
        - get
    - apiGroups:
        - security.openshift.io
      resourceNames:
        - ai-rhdh-pipelines-scc
      resources:
        - securitycontextconstraints
      verbs:
        - use
EOF
}

cleanCluster
provisionCluster
cleanNamespace
provisionNamespace
