terraform {
  backend "s3" {
    bucket = "cicd-terraform-eks-spatika"
    key    = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}