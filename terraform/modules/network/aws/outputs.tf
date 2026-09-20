# КОНТРАКТ: имена и типы должны совпадать с modules/network/hetzner/outputs.tf

output "network_id" {
  value = null # заменить на aws_vpc.this.id после реализации
}

output "subnet_ids" {
  value = {} # заменить на { for k, v in aws_subnet.this : k => v.id }
}
