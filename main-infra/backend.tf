# NOTE: Terraform does not allow variables inside a `backend` block —
# these values must be hardcoded (or passed via -backend-config flags).
# They correspond exactly to the outputs from the bootstrap/ project.

terraform {
  backend "s3" {
    bucket         = "devops-lab-tfstate-188776114506"
    key            = "main-infra/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
