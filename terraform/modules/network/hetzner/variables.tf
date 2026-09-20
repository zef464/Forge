variable "name" {
  description = "Логическое имя сети, напр. payments-staging"
  type        = string
}

variable "ip_range" {
  description = "CIDR всей приватной сети"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnets" {
  description = "Список подсетей: имя -> CIDR"
  type = map(object({
    ip_range = string
    zone     = string
  }))
  default = {
    app = {
      ip_range = "10.0.1.0/24"
      zone     = "eu-central"
    }
    monitoring = {
      ip_range = "10.0.2.0/24"
      zone     = "eu-central"
    }
  }
}

variable "labels" {
  description = "Общие labels/tags для ресурсов"
  type        = map(string)
  default     = {}
}
