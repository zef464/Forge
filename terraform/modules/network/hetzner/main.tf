terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_network" "this" {
  name     = var.name
  ip_range = var.ip_range
  labels   = var.labels
}

resource "hcloud_network_subnet" "this" {
  for_each     = var.subnets
  network_id   = hcloud_network.this.id
  type         = "cloud"
  network_zone = each.value.zone
  ip_range     = each.value.ip_range
}
