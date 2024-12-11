terraform {
  backend "s3" {
    bucket = "aace-my-tf-website-state"
    key = "global/s3/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-db-website-table"
  }
}