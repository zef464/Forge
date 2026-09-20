terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_firewall" "this" {
  name   = var.name
  labels = var.labels

  dynamic "rule" {
    for_each = [for r in var.rules : r if r.direction == "in"]
    content {
      direction  = "in"
      protocol   = rule.value.protocol
      port       = rule.value.port
      source_ips = rule.value.source_ips
    }
  }

  dynamic "rule" {
    for_each = [for r in var.rules : r if r.direction == "out"]
    content {
      direction       = "out"
      protocol        = rule.value.protocol
      port            = rule.value.port
      destination_ips = rule.value.source_ips
    }
  }
}
