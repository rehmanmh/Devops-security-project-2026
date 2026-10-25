resource "google_storage_bucket" "log_bucket" {
  #checkov:skip=CKV_GCP_62:Log bucket cannot log to itself
  #checkov:skip=CKV_GCP_63:Log bucket cannot log to itself
  name                        = "rk-secure-app-logs-bucket-2026"
  location                    = "US"
  force_destroy               = true
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}

resource "google_storage_bucket" "secure_bucket" {
  name          = "rk-secure-app-data-bucket-2026"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }

  logging {
    log_bucket        = google_storage_bucket.log_bucket.name
    log_object_prefix = "access-logs/"
  }
}
