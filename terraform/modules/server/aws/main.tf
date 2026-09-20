# TODO: реализовать через aws_instance, AMI lookup по var.image,
# security_groups = var.firewall_ids, subnet_id = var.subnet_id.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# resource "aws_instance" "this" { ... }

output "server_id" {
  value = null
}

output "public_ip" {
  value = null
}

output "private_ip" {
  value = null
}
