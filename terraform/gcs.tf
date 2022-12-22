resource "google_service_account" "loki_sa" {
  project       = module.service_project.project_id
  account_id    = "lokiiii"
}

resource "google_service_account_iam_member" "loki_wi_user" {
  service_account_id = google_service_account.loki_sa.name
  role               = "roles/iam.workloadIdentityUser"
  member             = format("serviceAccount:%s.svc.id.goog[loki/loki]", module.service_project.project_id)
}

resource "google_storage_bucket_iam_member" "loki_sa_chunks_objectadmin" {
  bucket = google_storage_bucket.loki-chunks.name
  role  = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.loki_sa.email)
}

resource "google_storage_bucket_iam_member" "loki_sa_ruler_objectadmin" {
  bucket = google_storage_bucket.loki-ruler.name
  role  = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.loki_sa.email)
}

resource "google_storage_bucket_iam_member" "loki_sa_admin_objectadmin" {
  bucket = google_storage_bucket.loki-admin.name
  role  = "roles/storage.objectAdmin"
  member = format("serviceAccount:%s", google_service_account.loki_sa.email)
}

resource "google_storage_bucket" "loki-chunks" {
  name          = format("loki-chunks-%s", random_id.random_suffix.hex)
  location      = var.region
  force_destroy = true

  project  = module.service_project.project_id
  uniform_bucket_level_access = true

}

resource "google_storage_bucket" "loki-ruler" {
  name          = format("loki-ruler-%s", random_id.random_suffix.hex)
  location      = var.region
  force_destroy = true

  project  = module.service_project.project_id
  uniform_bucket_level_access = true

}

resource "google_storage_bucket" "loki-admin" {
  name          = format("loki-admin-%s", random_id.random_suffix.hex)
  location      = var.region
  force_destroy = true

  project  = module.service_project.project_id
  uniform_bucket_level_access = true

}