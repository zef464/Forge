variable "name" {
  type = string
}

variable "network_id" {
  description = "У Yandex security group привязана к сети напрямую (в отличие от hetzner firewall, который присоединяется к серверу)"
  type        = string
}

variable "rules" {
  type = list(object({
    direction   = string # "in" | "out"
    protocol    = string # "tcp" | "udp" | "icmp" | "any"
    port        = string # "22" или "1000-2000" — модуль сам распарсит
    source_ips  = list(string)
    description = optional(string, "")
  }))
  default = []
}

variable "labels" {
  type    = map(string)
  default = {}
}
