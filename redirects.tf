
locals {
  redirect_url = "https://glueops.dev"
}

module "redirect_apex_domain" {
  source  = "TechNative-B-V/route53-s3-http-redirect/aws"
  version = "0.1.2"

  providers = {
    aws = aws.management-tenant-dns
  }
  zone_name           = aws_route53_zone.domain.name
  domain_name         = aws_route53_zone.domain.name
  redirect_target_url = local.redirect_url
}

module "redirect_www_domain" {
  source  = "TechNative-B-V/route53-s3-http-redirect/aws"
  version = "0.1.2"

  providers = {
    aws = aws.management-tenant-dns
  }
  zone_name           = aws_route53_zone.domain.name
  domain_name         = "www.${aws_route53_zone.domain.name}"
  redirect_target_url = local.redirect_url
}
