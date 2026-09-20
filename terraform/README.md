# Terraform modules — контракт multi-cloud

Каждый логический модуль (`network`, `server`, `firewall`) существует в двух видах:

```
modules/<module>/hetzner/   ← рабочая реализация
modules/<module>/aws/       ← тот же контракт variables/outputs, TODO внутри
```

## Правило

`variables.tf` и `outputs.tf` двух реализаций одного модуля должны быть
**идентичны по именам и типам**. Отличаться может только `main.tf` —
там, где абстрактные понятия (`size: small/medium/large`, `direction: in/out`)
превращаются в конкретные ресурсы провайдера.

## Почему не выбор провайдера через variable

Terraform не поддерживает динамический `source` в блоке `module`. Поэтому
переключение environment на другое облако — это осознанная правка трёх строк
`source = "../../modules/.../hetzner"` → `aws` в `environments/<env>/main.tf`,
а не runtime-флаг. Это сделано специально: выбор облака — решение уровня
environment, а не то, что должно тихо переключаться конфигом.

## Что реализовано сейчас

- `hetzner/*` — рабочий код (network, server, firewall).
- `aws/*` — только контракт (variables + outputs), ресурсы — TODO.

## Как добавить нового провайдера (например GCP)

1. Скопировать `variables.tf` из `hetzner`-версии модуля один в один.
2. Написать `main.tf` под конкретный provider.
3. `outputs.tf` — те же имена, значения из новых ресурсов.
4. Ничего в environments/, кроме `source =`, менять не нужно.
