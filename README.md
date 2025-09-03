# Terraform Module: ImgStudio for Google Cloud

This Terraform module deploys the ImgStudio application on Google Cloud. It sets up all the necessary infrastructure, including Cloud Run, Firestore, and Cloud Storage, to run the application securely and efficiently.

## Features

- Deploys the ImgStudio application as a Cloud Run service.
- Secures the application with Identity-Aware Proxy (IAP).
- Creates three Cloud Storage buckets for application data:
  - **Output Bucket:** Stores raw generated content.
  - **Library Bucket:** Hosts a shared library of assets.
  - **Config Bucket:** Holds application configuration files.
- Sets up a Firestore database in Native mode for application metadata.
- Configures necessary IAM roles and enables required Google Cloud APIs.

## Usage

Here's an example of how to use the module in your Terraform configuration:

```hcl
module "imgstudio" {
  source                 = "github.com/path/to/this/module"
  company_name           = "my-company"
  project_id             = "my-gcp-project-id"
  region                 = "us-central1"
  bucket_location        = "US"
  export_config_file_path = "path/to/your/export-fields-options.json"
  repostory_id           = "my-artifact-registry-repo"
  docker_image_name      = "imgstudio-app"
  docker_image_version   = "1.0.0"
  authorized_users       = [
    "user:jane.doe@example.com",
    "group:imgstudio-admins@example.com",
  ]
}
```

## Inputs

| Name                      | Description                                                                 | Type          | Default  | Required |
| ------------------------- | --------------------------------------------------------------------------- | ------------- | -------- | :------: |
| `company_name`            | The name of the company or organization.                                    | `string`      | -        |   yes    |
| `project_id`              | The ID of the project where the IaC resources will be created.                | `string`      | -        |   yes    |
| `region`                  | The region where the resources will be created.                             | `string`      | -        |   yes    |
| `bucket_location`         | The location for the GCS buckets.                                           | `string`      | -        |   yes    |
| `export_config_file_path` | Path to the export configuration file relative to the current directory.    | `string`      | -        |   yes    |
| `repostory_id`            | The ID of the repository where the Docker image of the service is.          | `string`      | -        |   yes    |
| `docker_image_name`       | The name of the Docker image for the service.                               | `string`      | -        |   yes    |
| `docker_image_version`    | The version tag of the Docker image for the service.                        | `string`      | `"latest"` |    no    |
| `authorized_users`        | List of users authorized to access the Cloud Run service via IAP.           | `list(string)`| -        |   yes    |

## Outputs

| Name                 | Description                                                    |
| -------------------- | -------------------------------------------------------------- |
| `imgstudio_url`      | The URL of the deployed ImgStudio application.                 |
| `output_bucket_name` | The name of the Cloud Storage bucket for raw generated content.|
| `library_bucket_name`| The name of the Cloud Storage bucket for the shared library.   |
| `config_bucket_name` | The name of the Cloud Storage bucket for the configuration file.|

## Requirements

### Terraform Providers

| Name          | Version   |
| ------------- | --------- |
| `google`      | `>= 7.0.0`|
| `google-beta` | `>= 7.0.0`|

### Google Cloud APIs

This module will enable the following Google Cloud APIs in your project:

- Cloud Run API (`run.googleapis.com`)
- Identity and Access Management (IAM) API (`iam.googleapis.com`)
- Cloud IAP API (`iap.googleapis.com`)
- Compute Engine API (`compute.googleapis.com`)
- Cloud Firestore API (`firestore.googleapis.com`)
- Cloud Storage API (`storage.googleapis.com`)
- Vertex AI API (`aiplatform.googleapis.com`)
