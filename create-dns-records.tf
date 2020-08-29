# Declare variables that stores access keys

# Configure the AWS Provider

provider "aws" {
  version    = "~> 2.0"
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

# Fetch data from route53

data "aws_route53_zone" "devops" {
  name = "devops.rebrain.srwx.net."
}

# Create DNS A records at devops.rebrain.srwx.net. zone

resource "aws_route53_record" "web1" {
  zone_id = data.aws_route53_zone.devops.zone_id
  name    = google_compute_instance.web_private_1.name
  type    = "A"
  ttl     = "300"
  records = [google_compute_instance.web_private_1.network_interface[0].access_config[0].nat_ip]
}

resource "aws_route53_record" "web2" {
  zone_id = data.aws_route53_zone.devops.zone_id
  name    = google_compute_instance.web_private_2.name
  type    = "A"
  ttl     = "300"
  records = [google_compute_instance.web_private_2.network_interface[0].access_config[0].nat_ip]
}

