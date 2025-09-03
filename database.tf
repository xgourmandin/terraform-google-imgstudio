# Firestore Database and Index
resource "google_firestore_database" "database" {
  project                     = var.project_id
  name                        = "(default)"
  location_id                 = var.region
  type                        = "FIRESTORE_NATIVE"
  delete_protection_state     = "DELETE_PROTECTION_DISABLED"
  app_engine_integration_mode = "DISABLED"

  depends_on = [google_project_service.apis]
}


resource "google_firestore_index" "metadata_index" {
  project    = var.project_id
  database   = google_firestore_database.database.name
  collection = "metadata"
  fields {
    field_path   = "combinedFilters"
    array_config = "CONTAINS"
  }
  fields {
    field_path = "timestamp"
    order      = "DESCENDING"
  }
  fields {
    field_path = "__name__"
    order      = "DESCENDING"
  }

}

resource "google_project_iam_member" "default" {
  project = var.project_id
  role    = "roles/datastore.user"
  member  = google_service_account.app_sa.member
}
