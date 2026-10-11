variable "app_name" {
  type    = string
  default = "payments"
}

variable "environment" {
  type    = string
  default = "dev"
}

# Публичный ключ, который попадёт на сервер в ~ubuntu/.ssh/authorized_keys.
# Храним путь, а не сам ключ: так файл .tf не зависит от конкретного человека,
# а каждый может переопределить путь через TF_VAR_ssh_public_key_path.
variable "ssh_public_key_path" {
  description = "Путь к публичному SSH-ключу (.pub), который пустит на сервер"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}
