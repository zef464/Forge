terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }
}

resource "hcloud_server" "this" {
  name         = var.name
  server_type  = local.size_map[var.size]
  image        = var.image
  firewall_ids = [for id in var.firewall_ids : tonumber(id)]
  ssh_keys     = var.ssh_key_ids
  labels       = var.labels

  network {
    network_id = tonumber(var.network_id)
    subnet_id  = var.subnet_id
  }
}
