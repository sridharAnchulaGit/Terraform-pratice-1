terraform {
  backend "s3" {
    bucket = "sridharr-anchulaa-buckets-2026"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-state-lock"
    #use_lockfile = true
  }
}