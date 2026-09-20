# TODO: реализовать через aws_vpc + aws_subnet (по одному aws_subnet на каждый
# элемент var.subnets, zone -> availability_zone).
# Пока модуль не реализован — намеренно, чтобы его нельзя было случайно
# подключить в environments/*.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# resource "aws_vpc" "this" { ... }
# resource "aws_subnet" "this" { for_each = var.subnets ... }
