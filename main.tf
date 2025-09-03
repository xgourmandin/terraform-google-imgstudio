# Enable necessary Google Cloud APIs
resource "google_project_service" "apis" {
  for_each = toset([
    "run.googleapis.com",
    "cloudbuild.googleapis.com",
    "iam.googleapis.com",
    "iap.googleapis.com",
    "compute.googleapis.com",
    "dns.googleapis.com",
    "firestore.googleapis.com",
    "artifactregistry.googleapis.com",
    "storage.googleapis.com",
    "aiplatform.googleapis.com"
  ])
  service            = each.key
  disable_on_destroy = false
}



