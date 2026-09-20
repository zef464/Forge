variable "name" {
  type = string
}

variable "size" {
  type    = string
  default = "small"

  validation {
    condition     = contains(["small", "medium", "large"], var.size)
    error_message = "size должен быть one of: small, medium, large"
  }
}

# У hetzner "image" — строка типа "ubuntu-24.04", напрямую применимая к API.
# У Yandex нужен image_id, который ищется через data source по family —
# поэтому здесь var.image остаётся "family", маппинг делает data-блок ниже.
variable "image" {
  type    = string
  default = "ubuntu-2404-lts"
}

variable "network_id" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "firewall_ids" {
  description = "Список security_group_id — по контракту список, как и у hetzner firewall_ids"
  type        = list(string)
  default     = []
}

variable "ssh_key_ids" {
  description = "У Yandex это не key id, а публичные ключи текстом (metadata ssh-keys). Контракт по имени переменной сохранён, содержимое — сами публичные ключи."
  type        = list(string)
  default     = []
}

variable "labels" {
  type    = map(string)
  default = {}
}

locals {
  # cores/memory в гигабайтах, platform_id один для всех размеров в этой
  # простой версии (standard-v3 — Intel Ice Lake)
  size_map = {
    small  = { cores = 2, memory = 2 }
    medium = { cores = 2, memory = 4 }
    large  = { cores = 4, memory = 8 }
  }
  platform_id = "standard-v3"
}
