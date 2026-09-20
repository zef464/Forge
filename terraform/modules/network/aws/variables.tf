# КОНТРАКТ: должен совпадать 1-в-1 с modules/network/hetzner/variables.tf

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
    zone     = string
  }))
  default = {}
}

variable "labels" {
  type    = map(string)
  default = {}
}
