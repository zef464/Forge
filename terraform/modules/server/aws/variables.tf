# КОНТРАКТ: должен совпадать с modules/server/hetzner/variables.tf

variable "name" {
  type = string
}

variable "size" {
  type    = string
  default = "small"
}

variable "image" {
  type    = string
  default = "ubuntu-24.04"
}

variable "network_id" {
  type = string
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
  # Свой маппинг size -> instance_type, не связан с hetzner size_map
  size_map = {
    small  = "t3.small"
    medium = "t3.medium"
    large  = "t3.large"
  }
}
