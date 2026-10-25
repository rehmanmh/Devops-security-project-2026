output "bucket_name" {
  description = "The name of the provisioned Google Cloud Storage bucket"
  value       = google_storage_bucket.secure_bucket.name
}

output "bucket_url" {
  description = "The base URL of the storage bucket"
  value       = google_storage_bucket.secure_bucket.url
}
