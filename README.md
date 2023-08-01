# terraform-module-cloud-aws-management-tenant-dns
<!-- BEGIN_TF_DOCS -->

This Terraform module creates/manages the hosted root zones for our tenant domains within AWS Route53. So in the case of onglueops.com this module will create a route53 zone for it and enable DNSSEC. Since we do not use route53 as our registrar you will need to set the SOA for onglueops.com at the registrar. After setting the SOA you will need to configure the DNSSEC record(s) at the registrar. You can grab the DNSSEC configurations from the AWS Console.

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws.management-tenant-dns"></a> [aws.management-tenant-dns](#provider\_aws.management-tenant-dns) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dnssec_key"></a> [dnssec\_key](#module\_dnssec\_key) | git::https://github.com/GlueOps/terraform-module-cloud-aws-dnssec-kms-key.git | v0.1.0 |
| <a name="module_redirect_apex_domain"></a> [redirect\_apex\_domain](#module\_redirect\_apex\_domain) | TechNative-B-V/route53-s3-http-redirect/aws | 0.1.2 |
| <a name="module_redirect_www_domain"></a> [redirect\_www\_domain](#module\_redirect\_www\_domain) | TechNative-B-V/route53-s3-http-redirect/aws | 0.1.2 |

## Resources

| Name | Type |
|------|------|
| [aws_route53_hosted_zone_dnssec.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_hosted_zone_dnssec) | resource |
| [aws_route53_key_signing_key.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_key_signing_key) | resource |
| [aws_route53_zone.domain](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID | `string` | n/a | yes |
| <a name="input_domain"></a> [domain](#input\_domain) | The root domain that will have their SOA delegated to AWS Route53 | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Management DNS that will be used for delegation for each tenant |
<!-- END_TF_DOCS -->