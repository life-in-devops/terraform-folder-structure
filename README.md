Terraform Folder Structure

This repository demonstrates a **scalable and maintainable Terraform folder structure** for provisioning AWS infrastructure across multiple environments: `dev`, `qad`, `stage`, and `prod`.

🚀 Purpose

The goal of this project is to provide a clean starting point for large-scale infrastructure projects using Terraform, following best practices like:

- Reusable modules
- Isolated environment configurations
- Remote state management
- Environment-specific variable files
- Easy CI/CD integration

📦 What’s Included

This PoC currently **demonstrates a simple Terraform module to provision an S3 bucket** per environment.

🧩 You can follow the same folder structure and module pattern to implement other AWS services such as VPCs, EC2, RDS, Lambda, IAM, etc.

🗂️ Folder Structure Overview

terraform-folder-structure/
├── backend/
│   ├── dev-backend.tf
│   ├── qad-backend.tf
│   ├── stage-backend.tf
│   └── prod-backend.tf
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── qad/
│   └── stage/
│   └── prod/
├── modules/
│   └── s3/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── .github/
    └── workflows/
        └── terraform.yml

🧩 Purpose of Each Folder

Folder	                                    Description
backend/	            Stores remote backend configuration (S3 + DynamoDB) per environment
environments/	        Each environment (e.g., dev, prod) has its own Terraform entrypoint
modules/	            Reusable infrastructure components (e.g., s3 bucket module)
.github/workflows/	    Contains GitHub Actions workflow for CI/CD automation


 ✅ Key Features

* ✅ Environment isolation (dev, qad, stage, prod)
* ✅ Remote backend configuration for state management
* ✅ Reusable module pattern
* ✅ Simple to scale with additional AWS resources
* ✅ Production-friendly structure

🔧 Use Cases

* Building environment-specific AWS infrastructure
* Automating deployments with Terraform and GitHub Actions
* Enabling secure infrastructure pipelines

📌 Requirements

* Terraform CLI (>= 1.5.0)
* AWS CLI with configured credentials
* S3 bucket and DynamoDB table for backend state (manually created or provisioned separately)

🔐 Backend (Remote State & Locking)
You're using S3 + DynamoDB for Terraform state and locking.

Example: backend/dev-backend.tf

terraform {
  backend "s3" {
    bucket         = "my-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}

🔐 The terraform-locks DynamoDB table must be created once and shared across all environments.

⚙️ GitHub Actions: terraform.yml
This single workflow handles both:

Automatic plan on code change (per environment)

Manual apply or destroy via trigger

✅ Behavior Summary

Trigger Type	            Action
push to main	    Detect changed environments → run plan only
workflow_dispatch	Manually trigger apply or destroy

🔧 Required GitHub Secrets
In your repo settings:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

Used by the workflow to authenticate with AWS.

📄 Workflow: .github/workflows/terraform.yml
Paste the latest version of the file here (already shared above) into .github/workflows/terraform.yml.

✅ Deployment Flow
1. Automatic Plan (on Push)
Whenever you push to main:

It checks which environments have changed (git diff)

Runs terraform init, validate, and plan for only those environments

No infrastructure is modified yet

📍 Example:
You change environments/dev/main.tf → only dev will be planned.

2. Manual Apply or Destroy
To perform an actual deployment (apply/destroy):

Go to GitHub → Actions → Terraform Plan, Apply & Destroy

Click Run workflow

Select:

environment (dev, qad, stage, prod)

action: apply or destroy

💡 Only the selected environment is affected.

🧪 Local Testing (Optional)
To test locally before pushing:

cd environments/dev
terraform init -backend-config=../../backend/dev-backend.tf
terraform plan -var-file="terraform.tfvars"


🔄 Future Enhancements (Optional)

        Feature	                                Benefit
Manual approval for prod	        Prevent accidental production changes
Save plan as artifact	            Keep record of planned changes
Slack or Teams notification	        Alert team on changes
PR comments with plan	Dev         visibility in code review