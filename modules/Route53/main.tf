data "aws_route53_zone" "selected" {
    name = "tuilalinh.id.vn"
}

data "aws_lbs" "nginx_arn" {
  tags = {
   "kubernetes.io/cluster/group15-cluster" = "owned"
   "kubernetes.io/service-name"    = "ingress-nginx/ingress-nginx-controller"
  }
}

data "aws_lb" "nginx_lb" {
  count = length(tolist(data.aws_lbs.nginx_arn.arns)) > 0 ? 1 : 0
  arn = length(tolist(data.aws_lbs.nginx_arn.arns)) > 0 ? tolist(data.aws_lbs.nginx_arn.arns)[0] : ""
}

resource "aws_route53_record" "frontend" {
  count  = length(tolist(data.aws_lbs.nginx_arn.arns)) > 0 ? 1 : 0
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "tuilalinh.id.vn"
  type    = "A"

  alias {
    name                   = data.aws_lb.nginx_lb[0].dns_name
    zone_id                = data.aws_lb.nginx_lb[0].zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "backend" {
  count  = length(tolist(data.aws_lbs.nginx_arn.arns)) > 0 ? 1 : 0
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "api.tuilalinh.id.vn"
  type    = "A"

  alias {
    name                   = data.aws_lb.nginx_lb[0].dns_name
    zone_id                = data.aws_lb.nginx_lb[0].zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "admin" {
  count  = length(tolist(data.aws_lbs.nginx_arn.arns)) > 0 ? 1 : 0
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "admin.tuilalinh.id.vn"
  type    = "A"

  alias {
    name                   = data.aws_lb.nginx_lb[0].dns_name
    zone_id                = data.aws_lb.nginx_lb[0].zone_id
    evaluate_target_health = true
  }
}