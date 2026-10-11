terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

locals {
  # "22" -> [22,22], "1000-2000" -> [1000,2000]
  parsed_rules = [
    for r in var.rules : merge(r, {
      port_range = length(split("-", r.port)) == 2 ? split("-", r.port) : [r.port, r.port]
    })
  ]
}

resource "yandex_vpc_security_group" "this" {
  name       = var.name
  network_id = var.network_id
  labels     = var.labels

  dynamic "ingress" {
    for_each = [for r in local.parsed_rules : r if r.direction == "in"]
    content {
      protocol       = ingress.value.protocol
      description    = ingress.value.description
      v4_cidr_blocks = ingress.value.source_ips
      from_port      = tonumber(ingress.value.port_range[0])
      to_port        = tonumber(ingress.value.port_range[1])
    }
  }

  dynamic "egress" {
    for_each = [for r in local.parsed_rules : r if r.direction == "out"]
    content {
      protocol       = egress.value.protocol
      description    = egress.value.description
      v4_cidr_blocks = egress.value.source_ips
      from_port      = tonumber(egress.value.port_range[0])
      to_port        = tonumber(egress.value.port_range[1])
    }
  }
}
