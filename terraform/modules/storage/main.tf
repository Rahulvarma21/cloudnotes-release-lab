# Reusable "storage bucket" module. Modeled with local_file so it can be
# validated/planned with zero cost and no cloud credentials.
resource "local_file" "bucket_metadata" {
  filename = "${path.module}/../../.generated/${var.environment}-${var.bucket_name}.json"
  content = jsonencode({
    bucket_name = var.bucket_name
    environment = var.environment
    labels      = var.labels
  })
}
