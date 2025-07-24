resource "aws_s3_bucket" "this" {
  bucket = "${var.env}-s3-bucket-for-terraform-poc"

  tags = {
    Environment = var.env
    ManagedBy   = "Terraform"
  }
}
