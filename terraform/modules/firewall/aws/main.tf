# TODO: реализовать через aws_security_group, маппинг var.rules ->
# ingress/egress блоки (direction "in" -> ingress, "out" -> egress).

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "name" {
  type = string
}

variable "rules" {
  type = list(object({
    direction   = string
    protocol    = string
    port        = string
    source_ips  = list(string)
    description = optional(string, "")
  }))
  default = []
}

variable "labels" {
  type    = map(string)
  default = {}
}

# resource "aws_security_group" "this" { ... }

output "firewall_id" {
  value = null
}
