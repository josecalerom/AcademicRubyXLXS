.DEFAULT_GOAL := help

help: ## Show this help
	@echo -e "usage: make [target]\n\ntarget:"
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

build: ## builds database and performs migrates
	ruby lib/db/create.rb
	ruby lib/db/migrate.rb

db_create: ## creates the database
	ruby lib/db/create.rb

db_migrate: ## migrates the database
	ruby lib/db/migrate.rb

db_drop: ## drops the database
	ruby lib/db/drop.rb
