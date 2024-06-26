provider "aws" {
  alias  = "management-tenant-dns"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/OrganizationAccountAccessRole"
  }
}

variable "aws_account_id" {
  description = "The AWS Account ID"
  type        = string
  nullable    = false
}


variable "domain" {
  description = "The root domain that will have their SOA delegated to AWS Route53"
  type        = string
  nullable    = false
}

module "dnssec_key" {
  source         = "git::https://github.com/GlueOps/terraform-module-cloud-aws-dnssec-kms-key.git?ref=v0.3.0"
  aws_account_id = var.aws_account_id
}

resource "aws_route53_zone" "domain" {
  provider = aws.management-tenant-dns
  name     = var.domain
}

output "zone_id" {
  value       = aws_route53_zone.domain.id
  description = "Management DNS that will be used for delegation for each tenant"
}

resource "aws_route53_key_signing_key" "primary" {
  provider                   = aws.management-tenant-dns
  hosted_zone_id             = aws_route53_zone.domain.id
  key_management_service_arn = module.dnssec_key.kms_key_arn
  name                       = "primary"
  status                     = "ACTIVE"
}

resource "aws_route53_hosted_zone_dnssec" "primary" {
  provider = aws.management-tenant-dns
  depends_on = [
    aws_route53_key_signing_key.primary
  ]
  hosted_zone_id = aws_route53_key_signing_key.primary.hosted_zone_id
}
