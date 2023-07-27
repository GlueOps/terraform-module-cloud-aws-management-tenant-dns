
locals {
  redirect_url = "https://glueops.dev"
}

module "redirect_apex_domain" {
  source = "git::https://github.com/Technative-B-V/terraform-aws-route53-s3-http-redirect.git?ref=v0.1.1"
  providers = {
    aws = aws.management-tenant-dns
  }
  zone_name           = aws_route53_zone.domain.name
  domain_name         = aws_route53_zone.domain.name
  redirect_target_url = local.redirect_url
}

module "redirect_www_domain" {
  source = "git::https://github.com/Technative-B-V/terraform-aws-route53-s3-http-redirect.git?ref=v0.1.1"
  providers = {
    aws = aws.management-tenant-dns
  }
  zone_name           = aws_route53_zone.domain.name
  domain_name         = "www.${aws_route53_zone.domain.name}"
  redirect_target_url = local.redirect_url
}