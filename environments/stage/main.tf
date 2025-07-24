provider "aws" {
  region = var.region
}

module "s3_bucket" {
  source = "../../modules/s3"
  env    = var.env
}
