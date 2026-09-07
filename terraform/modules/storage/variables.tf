variable "bucket_name" {
  description = "Logical name for the storage bucket."
  type        = string
}

variable "environment" {
  description = "Environment this bucket belongs to."
  type        = string
}

variable "labels" {
  description = "Labels/tags to attach to the bucket metadata."
  type        = map(string)
  default     = {}
}
