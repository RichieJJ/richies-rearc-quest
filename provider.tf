terraform {
  required_version = "1.3.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.50.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

output "rearc-quest-alb-dns-http-url" {
  depends_on = [aws_alb.rearc-quest-alb]
  value      = "http://${aws_alb.rearc-quest-alb.dns_name}"
}

# output "rearc-quest-alb-dns-https-url" {
#   depends_on = [aws_alb.rearc-quest-alb]
#   value = "https://${aws_alb.rearc-quest-alb.dns_name}"
# }
