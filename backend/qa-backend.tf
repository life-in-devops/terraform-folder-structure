terraform {
  backend "s3" {
    bucket         = "devops-projects-terraform"
    key            = "qa/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
  }
}
