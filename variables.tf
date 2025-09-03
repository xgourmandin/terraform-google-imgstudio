variable "company_name" {
  description = "The name of the company or organization"
  type        = string
}

variable "project_id" {
  description = "The ID of the project where the IaC resources will be created"
  type        = string
}

variable "region" {
  description = "The region where the resources will be created."
  type        = string
}

variable "bucket_location" {
  description = "The location for the GCS bucket."
  type        = string
}

variable "export_config_file_path" {
  description = "Path to the export configuration file relative to the current directory."
  type        = string
}

variable "repostory_id" {
  description = "The ID of the repository where the Docker image of the service is"
  type        = string
}

variable "docker_image_name" {
  description = "The name of the Docker image for the service"
  type        = string
}

variable "docker_image_version" {
  description = "The version tag of the Docker image for the service"
  type        = string
  default     = "latest"
}

variable "authorized_users" {
  description = "List of users authorized to access the Cloud Run service via IAP"
  type        = list(string)
}