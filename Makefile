# Быстрые проверки Terraform-кода. Ни одна из этих целей не ходит в облако
# и не трогает state, поэтому их безопасно запускать когда угодно.
#
#   make fmt         — переформатировать все .tf файлы
#   make fmt-check   — только проверить формат (так делает CI)
#   make validate    — проверить синтаксис и типы в каждом окружении

TF       ?= terraform
TF_DIR   := terraform
# Окружения, в которых уже есть код. staging и prod добавим, когда заполним.
ENVS     ?= dev

.PHONY: fmt fmt-check validate

fmt:
	$(TF) fmt -recursive $(TF_DIR)

fmt-check:
	$(TF) fmt -recursive -check -diff $(TF_DIR)

# -backend=false: init скачивает провайдеры и модули, но не подключается к
# remote state. Для validate state не нужен, а значит не нужны и ключи от бакета.
validate:
	@for env in $(ENVS); do \
		echo "==> $(TF_DIR)/environments/$$env"; \
		$(TF) -chdir=$(TF_DIR)/environments/$$env init -backend=false -input=false >/dev/null || exit 1; \
		$(TF) -chdir=$(TF_DIR)/environments/$$env validate || exit 1; \
	done
