terraform {
  # >= 1.10 нужен для use_lockfile в S3-backend (см. backend.tf.example)
  required_version = ">= 1.10"

  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      # ~> 0.228 = любая 0.x начиная с 0.228 (0.229, 0.240...), но не 1.0.
      # Точная версия всё равно фиксируется в .terraform.lock.hcl.
      version = "~> 0.228"
    }
  }
}

variable "yc_token" {
  description = "OAuth или IAM токен. Лучше передавать через переменную окружения YC_TOKEN, не хранить в tfvars"
  type        = string
  sensitive   = true
  default     = null
}

variable "yc_cloud_id" {
  type = string
}

variable "yc_folder_id" {
  type = string
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

locals {
  labels = {
    app         = var.app_name
    environment = var.environment
  }
}

# Terraform не умеет динамически подставлять source модуля, поэтому переход
# на другое облако — это правка ровно трёх строк source= ниже. Реализации:
# modules/*/yandex (рабочая, основная), modules/*/hetzner (рабочая, запасная),
# modules/*/aws (контракт-заглушка, TODO).

module "network" {
  source = "../../modules/network/yandex"

  name     = "${var.app_name}-${var.environment}"
  ip_range = "10.0.0.0/16"
  labels   = local.labels
}

module "firewall" {
  source = "../../modules/firewall/yandex"

  name       = "${var.app_name}-${var.environment}"
  network_id = module.network.network_id
  rules = [
    {
      direction   = "in"
      protocol    = "tcp"
      port        = "22"
      source_ips  = ["0.0.0.0/0"]
      description = "ssh"
    },
    {
      direction   = "in"
      protocol    = "tcp"
      port        = "443"
      source_ips  = ["0.0.0.0/0"]
      description = "https"
    }
  ]
  labels = local.labels
}

module "application" {
  source = "../../modules/server/yandex"

  name         = "${var.app_name}-${var.environment}"
  size         = "small"
  network_id   = module.network.network_id
  subnet_id    = module.network.subnet_ids["app"]
  firewall_ids = [module.firewall.firewall_id]
  labels       = local.labels
}
