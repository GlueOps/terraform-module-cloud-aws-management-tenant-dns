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

module "dnssec_key" {
  source         = "git::https://github.com/GlueOps/terraform-module-cloud-aws-dnssec-kms-key.git?ref=feat/adding-kms"
  aws_account_id = var.aws_account_id
}

resource "aws_route53_zone" "domains" {
  for_each = toset(var.domains)
  name     = each.value
}

resource "aws_route53_key_signing_key" "primary" {
  for_each                   = toset(var.domains)
  hosted_zone_id             = aws_route53_zone.domains[each.value].id
  key_management_service_arn = module.dnssec_key.kms_key_arn
  name                       = "primary"
  status                     = "ACTIVE"
}

