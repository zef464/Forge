output "network_id" {
  value = yandex_vpc_network.this.id
}

output "subnet_ids" {
  value = { for k, v in yandex_vpc_subnet.this : k => v.id }
}
