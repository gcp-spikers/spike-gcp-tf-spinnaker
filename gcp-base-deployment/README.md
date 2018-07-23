# Steps for Deployment Manager for Circle CI on GCP

### You will need a new project and bucket since buckets are global, change values in the following sections. Then run the remaining commands.

1. Enable the following API's
    * Resource Manager
    * Deployment Manager
    * IAM Manager
    * Compute Engine

2. Make the cloudservices SA an owner or Project IAM Admin of the project:
    - projectNumber@cloudservices.gserviceaccount.com

3. Replace the 'project' value in the following files/positions:
    * ./project.jinja
        * resource

4. Replace bucket value in the following files/positions:
    * ./main.yaml name for type: storage_bucket.jinja

5. 
```
gcloud deployment-manager deployments create deploy-terraform-service-account --config ./main.yaml
```

6. If you need to update, substitute 'create' for 'update'
```
gcloud deployment-manager deployments create deploy-terraform-service-account --config ./main.yaml
```
