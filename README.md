# dance-standard-pipelines

These pipelines are in standard tekton format. They can be found in ./pac/pipelines and ./pac/tasks.
The .tekton directories for default pipeline can be found in the ./pac as builders

THis repository also has openshift formatted templates in ./openshift-templates

# Install 

1. To use these pipelines, copy the appropriate build from ./pac into .tekton and customize as needed.

    - `docker-build-shared` uses dockerfiles to build your app 
    - `nodejs-build` node - npm based build for node.js 
    - `java-build` -  s2i-java builder
  
    - PaC Pipeline Runs marked `shared` will use a shared configuration for automatic pipeline updates from your centrally managed Standard Pipelines

3. Modify the copied files using the placeholders names in template format for the specifics for your application

   - `{{values.appName}}`  - the app name for your component 
   - `{{values.dockerfileLocation}}`  - the dockerfile location for your component
   - `{{values.namespace}}`  - the namespace location for your component
   - `{{values.image}}`  - the image for your destination 
   - `{{values.namespace}}`  - the namespace location for your component
   - `{{values.buildContext}}`  - the namespace location for your component
   - `{{values.repoURL}}` - the repository url for the generated repository
    

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
     