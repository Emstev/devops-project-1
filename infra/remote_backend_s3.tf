terraform {
  backend "s3" {
    bucket = "myjenkinsbucket-ca"
    key    = "devops-project-1/terraform.tfstate"
    region = "eu-central-1"
  }
}
