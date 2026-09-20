terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

resource "yandex_vpc_network" "this" {
  name   = var.name
  labels = var.labels
}

# У Yandex подсеть привязана к конкретной зоне (AZ), а не к абстрактной "зоне
# сети" как у hetzner network_zone — поэтому each.value.zone тут используется
# напрямую как zone ресурса.
resource "yandex_vpc_subnet" "this" {
  for_each       = var.subnets
  name           = "${var.name}-${each.key}"
  network_id     = yandex_vpc_network.this.id
  zone           = each.value.zone
  v4_cidr_blocks = [each.value.ip_range]
  labels         = var.labels
}
