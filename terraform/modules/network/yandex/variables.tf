# КОНТРАКТ: имена/типы совпадают с modules/network/hetzner/variables.tf.
# zone у Yandex — не network_zone как у hetzner, а конкретная AZ (ru-central1-a
# и т.д.), но наружу это всё равно "zone" — детали остаются внутри модуля.

variable "name" {
  type = string
}

variable "ip_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = map(object({
    ip_range = string
    zone     = string # напр. "ru-central1-a"
  }))
  default = {
    app = {
      ip_range = "10.0.1.0/24"
      zone     = "ru-central1-a"
    }
    monitoring = {
      ip_range = "10.0.2.0/24"
      zone     = "ru-central1-a"
    }
  }
}

variable "labels" {
  type    = map(string)
  default = {}
}
