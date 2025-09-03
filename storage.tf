
# Cloud Storage Buckets
resource "google_storage_bucket" "output" {
  name          = "${var.company_name}-imgstudio-output"
  location      = var.bucket_location
  force_destroy = true
}

resource "google_storage_bucket" "library" {
  name          = "${var.company_name}-imgstudio-library"
  location      = var.bucket_location
  force_destroy = true
}

resource "google_storage_bucket" "config" {
  name          = "${var.company_name}-imgstudio-export-config"
  location      = var.bucket_location
  force_destroy = true
}

resource "google_storage_bucket_object" "config_file" {
  name   = "export-fields-options.json"
  bucket = google_storage_bucket.config.name
  source = var.export_config_file_path
}


