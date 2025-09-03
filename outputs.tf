output "imgstudio_url" {
  description = "The URL of the deployed ImgStudio application."
  value       = google_cloud_run_v2_service.imgstudio_app.uri
}

output "output_bucket_name" {
  description = "The name of the Cloud Storage bucket for raw generated content."
  value       = google_storage_bucket.output.name
}

output "library_bucket_name" {
  description = "The name of the Cloud Storage bucket for the shared library."
  value       = google_storage_bucket.library.name
}

output "config_bucket_name" {
  description = "The name of the Cloud Storage bucket for the configuration file."
  value       = google_storage_bucket.config.name
}
