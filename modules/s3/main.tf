resource "aws_s3_bucket" "this" {
  bucket = "${var.env}-terraform-backend-s3-bucket"

  tags = {
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}
