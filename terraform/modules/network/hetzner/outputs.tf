# Эти outputs — контракт. Любая другая провайдерская реализация network-модуля
# (aws, gcp, ...) обязана отдавать те же имена и типы, иначе server/firewall модули
# станут cloud-specific.

output "network_id" {
  description = "ID сети для передачи в server/firewall модули"
  value       = hcloud_network.this.id
}

output "subnet_ids" {
  description = "Карта имя_подсети -> id подсети"
  value       = { for k, v in hcloud_network_subnet.this : k => v.id }
}
