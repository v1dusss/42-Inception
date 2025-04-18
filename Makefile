DOCKER_COMPOSE = docker compose -f src/docker-compose.yml
DATA_PATH = $(HOME)/data

all: up

up:
	@bash src/check_env.sh
	@if [ ! -d $(DATA_PATH) ]; then \
		echo "Creating data directory..."; \
		mkdir -p $(DATA_PATH); \
		chmod -R 777 $(DATA_PATH); \
	fi
	@if [ ! -d $(DATA_PATH)/mariadb ]; then \
		echo "Creating mariadb data directory..."; \
		mkdir -p $(DATA_PATH)/mariadb; \
		chmod -R 777 $(DATA_PATH)/mariadb; \
	fi
	@if [ ! -d $(DATA_PATH)/wordpress ]; then \
		echo "Creating wordpress data directory..."; \
		mkdir -p $(DATA_PATH)/wordpress; \
		chmod -R 777 $(DATA_PATH)/wordpress; \
	fi
	@mkdir -p src/secrets
	@echo "Building and starting containers..."
	$(DOCKER_COMPOSE) up --build

build:
	@echo "Building Docker images..."
	$(DOCKER_COMPOSE) build

down:
	@echo "Stopping containers..."
	$(DOCKER_COMPOSE) down

clean: down
	@echo "Removing SSL certificates..."
	@rm -rf src/secrets
	@echo "Removing Docker containers and images..."
	@docker system prune -a --force

fclean: clean
	@echo "Cleaning Docker resources..."
	@docker volume rm $$(docker volume ls -q) 2>/dev/null || true
	@docker network rm $$(docker network ls -q) 2>/dev/null || true
	@echo "Removing data directories..."
	@sudo rm -rf $(DATA_PATH)

re: clean all

status:
	@echo "Container status:"
	@$(DOCKER_COMPOSE) ps
	@echo "\nVolumes:"
	@docker volume ls
	@echo "\nNetworks:"
	@docker network ls

# Enter a shell in a specific container
# Usage: make shell SERVICE=servicename
shell:
	$(DOCKER_COMPOSE) exec $(SERVICE) bash

# Display logs for containers
# Usage: make logs SERVICE=servicename (optional)
logs:
	@if [ -z "$(SERVICE)" ]; then \
		$(DOCKER_COMPOSE) logs; \
	else \
		$(DOCKER_COMPOSE) logs $(SERVICE); \
	fi

.PHONY: all up build down clean fclean re status shell logs