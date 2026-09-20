variable "name" {
  type = string
}

# Ключевой момент cloud-agnostic подхода: environment не знает про "cx22",
# он выбирает абстрактный size. Маппинг size -> конкретный тип живёт здесь,
# внутри провайдерской реализации.
variable "size" {
  description = "Абстрактный размер: small | medium | large"
  type        = string
  default     = "small"

  validation {
    condition     = contains(["small", "medium", "large"], var.size)
    error_message = "size должен быть one of: small, medium, large"
  }
}

variable "image" {
  description = "Абстрактное имя образа, напр. ubuntu-24.04"
  type        = string
  default     = "ubuntu-24.04"
}

variable "network_id" {
  description = "network_id из network-модуля"
  type        = string
}

variable "subnet_id" {
  type = string
}

variable "firewall_ids" {
  type    = list(string)
  default = []
}

variable "ssh_key_ids" {
  type    = list(string)
  default = []
}

variable "labels" {
  type    = map(string)
  default = {}
}

locals {
  # Единственное место, где абстрактный size превращается в hcloud server_type.
  size_map = {
    small  = "cx22"
    medium = "cx32"
    large  = "cx42"
  }
}
