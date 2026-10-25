resource "google_storage_bucket" "secure_bucket" {
  name          = "rk-secure-app-data-bucket-2026"
  location      = "US"
  force_destroy = true

  # Security Best Practices (Checkov compliance)
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  versioning {
    enabled = true
  }
}
