# AI-RHDH Standard Pipelines

These pipelines are in standard [tekton](https://tekton.dev/docs/) format.
They can be found in ./pac/pipelines and ./pac/tasks.

This pipeline was forked and customized from the RHTAP [pipeline definition](https://github.com/redhat-appstudio/tssc-sample-pipelines) and plans to act standalone from RHTAP.

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
