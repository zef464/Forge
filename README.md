Главная идея:

```
Developer
   │
   │  forge create payments --env staging
   ▼
┌──────────────────────────────────────────────────────┐
│                       Forge CLI                      │
└────────────────────────┬─────────────────────────────┘
                         │
                         ▼
                    GitHub Actions
                         │
             ┌───────────┴───────────┐
             ▼                       ▼
        Terraform                 Ansible
             │                       │
             ▼                       ▼
      Infrastructure            Configuration
             │                       │
             └───────────┬───────────┘
                         ▼
                    Application
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
           Metrics      Logs       Alerts
              │          │          │
              └──────────┴──────────┘
                         ▼
                  Grafana / Loki
```