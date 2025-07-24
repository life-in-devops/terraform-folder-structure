    bucket         = "devops-projects-terraform"
    key            = "stage/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "tf-lock-table"
    encrypt        = true
