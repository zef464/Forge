variable "name" {
  type = string
}

# Провайдер-независимая форма правил — тот же shape должен принимать aws-модуль,
# внутри он просто маппится в security group rules.
variable "rules" {
  description = "Список firewall-правил"
  type = list(object({
    direction   = string # "in" | "out"
    protocol    = string # "tcp" | "udp" | "icmp"
    port        = string # "22", "80", "1000-2000"
    source_ips  = list(string)
    description = optional(string, "")
  }))
  default = []
}

variable "labels" {
  type    = map(string)
  default = {}
}
