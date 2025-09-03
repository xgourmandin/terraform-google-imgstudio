
# Application Service Account
resource "google_service_account" "app_sa" {
  account_id   = "${var.company_name}-imgstudio-sa"
  display_name = "ImgStudio Application Service Account"
}

resource "google_project_iam_member" "app_sa_roles" {
  for_each = toset([
    "roles/datastore.user",
    "roles/logging.logWriter",
    "roles/secretmanager.secretAccessor",
    "roles/iam.serviceAccountTokenCreator",
    "roles/storage.objectUser",
    "roles/aiplatform.user"
  ])
  project = var.project_id
  role    = each.key
  member  = google_service_account.app_sa.member
}

# Cloud Run Service
data "google_artifact_registry_docker_image" "image" {
  project       = var.project_id
  location      = var.region
  repository_id = var.repostory_id
  image_name    = "${var.docker_image_name}:${var.docker_image_version}"
}

resource "google_cloud_run_v2_service" "imgstudio_app" {
  provider            = google-beta
  name                = "${var.company_name}-imgstudio-app"
  location            = var.region
  launch_stage        = "BETA"
  ingress             = "INGRESS_TRAFFIC_ALL"
  iap_enabled         = true
  deletion_protection = false

  template {
    service_account = google_service_account.app_sa.email
    containers {
      image = data.google_artifact_registry_docker_image.image.self_link
      ports {
        container_port = 3000
      }
    }
  }

  depends_on = [google_project_service.apis, google_firestore_database.database]
}

data "google_project" "current" {}

resource "google_cloud_run_service_iam_binding" "iap" {
  location = google_cloud_run_v2_service.imgstudio_app.location
  service  = google_cloud_run_v2_service.imgstudio_app.name
  role     = "roles/run.invoker"
  members = [
    "serviceAccount:service-${data.google_project.current.number}@gcp-sa-iap.iam.gserviceaccount.com",
  ]
}

resource "google_iap_web_cloud_run_service_iam_member" "member" {
  for_each               = toset(var.authorized_users)
  project                = google_cloud_run_v2_service.imgstudio_app.project
  location               = google_cloud_run_v2_service.imgstudio_app.location
  cloud_run_service_name = google_cloud_run_v2_service.imgstudio_app.name
  role                   = "roles/iap.httpsResourceAccessor"
  member                 = "user:xavier.gourmandin@stack-labs.com"
}

resource "google_cloud_run_service_iam_member" "noauth" {
  location = google_cloud_run_v2_service.imgstudio_app.location
  role     = "roles/run.invoker"
  member   = "allUsers"
  service  = google_cloud_run_v2_service.imgstudio_app.name
}
