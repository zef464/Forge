output "server_public_ip" {
  value = module.application.public_ip
}

output "server_private_ip" {
  value = module.application.private_ip
}
