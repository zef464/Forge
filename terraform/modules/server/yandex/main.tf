terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

data "yandex_compute_image" "this" {
  family = var.image
}

resource "yandex_compute_instance" "this" {
  name        = var.name
  platform_id = local.platform_id
  labels      = var.labels

  resources {
    cores  = local.size_map[var.size].cores
    memory = local.size_map[var.size].memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.this.id
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    security_group_ids = var.firewall_ids
    nat                = true # публичный IP; для чисто приватных серверов вынести в переменную
  }

  metadata = {
    ssh-keys = join("\n", [for k in var.ssh_key_ids : "ubuntu:${k}"])
  }
}
