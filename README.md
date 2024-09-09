# AI-RHDH Standard Pipelines

These pipelines are in standard tekton format.
They can be found in ./pac/pipelines and ./pac/tasks.

# Installation and Usage

Depending on the use case there are two ways of consuming of the AI-RHDH pipeline:
 - [consuming unmodified pipeline](#consuming-unmodified-pipeline)
 - [consuming customized pipeline](#consuming-customized-pipeline)

## Consuming Unmodified Pipeline

For this scenario, the AI-RHDH [pipeline definition](https://github.com/redhat-appstudio/tssc-sample-pipelines/blob/main/pac/pipelines/docker-build-ai-rhdh.yaml) can be directly referenced from the [official](https://github.com/redhat-appstudio/tssc-sample-pipelines) repository.
In such case, all the updates and security pathes will be available immediately.
No actions required from the consumer side.

## Consuming customized pipeline

If any customization to the default AI-RHDH [pipeline definition](https://github.com/redhat-appstudio/tssc-sample-pipelines/blob/main/pac/pipelines/docker-build-ai-rhdh.yaml) is needed or immediate updates are not desired, workflow described in this section should be taken.

Fork this repository and modify the default AI-RHDH pipeline definition according to your needs.
Reference the modified version of the pipeline.

To consume CVEs fixes and pipeline updates, one should rebase changes in the fork on top of the new AI-RHDH pipeline version.

## Backstage

Modify the template placeholders to match your backstage template vars
Note, PaC also has `{{variables}}` and you should not modify those.

   - `{{values.appName}} -> ${{ values.appName }}`
   - `{{values.dockerfileLocation}}-> ${{ values.dockerfileLocation }} `
   - `{{values.namespace}}-> ${{ values.namespace }} `
   - `{{values.image}}-> ${{ values.image }} `
   - `{{values.namespace}}-> ${{ values.namespace }} `
   - `{{values.buildContext}}-> ${{ values.buildContext }} `
   - `{{values.repoURL}}-> ${{values.repoURL}}`
