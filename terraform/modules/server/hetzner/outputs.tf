output "server_id" {
  value = hcloud_server.this.id
}

output "public_ip" {
  value = hcloud_server.this.ipv4_address
}

output "private_ip" {
  value = hcloud_server.this.network[0].ip
}
