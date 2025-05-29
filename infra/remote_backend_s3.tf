terraform {
  backend "s3" {
    bucket = "cba-proj-1-jenkins-remote-state-bucket-latest1"
    key    = "devops-project-1/terraform.tfstate"
    region = "eu-central"
  }
}
