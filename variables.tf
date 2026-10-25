variable "gcp_project_id" {
  type        = string
  description = "Your Google Cloud Project ID"
}

variable "gcp_region" {
  type        = string
  description = "The target GCP region"
  default     = "us-central1"
}

variable "gcp_zone" {
  type        = string
  description = "The target GCP zone"
  default     = "us-central1-a"
}
