terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.59.0"
    }
  }
}

variable "aws_account_id" {
  description = "The AWS Account ID"
  type        = string
  nullable    = false
}


variable "domains" {
  description = "The root domains that will have their SOA delegated to AWS Route53"
  type        = list(string)
  nullable    = false
}

module "dnssec_kms_key" {
  source         = "https://github.com/GlueOps/terraform-module-cloud-aws-dnssec-kms-key.git?ref=feat/adding-kms"
  aws_account_id = var.aws_account_id

}


