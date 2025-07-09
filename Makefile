include srcs/.env

COMPOSE_FILE = srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)
DB_VOLUME = /home/$(USER)/data/wordpress_db
WP_VOLUME = /home/$(USER)/data/wordpress
VOLUMES = $(DB_VOLUME) $(WP_VOLUME)

all: hostsed_add build

create_volume:
	@echo "Creating local volumes..."
	@mkdir -p $(VOLUMES)

delete_volume:
	@echo "Deleting local volumes..."
	@sudo rm -rf $(VOLUMES)

check_hostsed:
	@dpkg -s hostsed >/dev/null 2>&1 || (echo "hostsed not found, installing..." && sudo apt update && sudo apt install -y hostsed)

hostsed_add: check_hostsed
	@sudo hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	@echo "$(DOMAIN_NAME) added to hosts."

hostsed_rm: check_hostsed
	@sudo hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	@echo "$(DOMAIN_NAME) removed from hosts."

build: create_volume
	@$(COMPOSE) up --build -d

up:
	@echo "Starting services..."
	@$(COMPOSE) up -d

down:
	@echo "Stopping services..."
	@$(COMPOSE) down

stop:
	@echo "Stopping containers..."
	@$(COMPOSE) stop
	@echo "Containers stopped."

start:
	@echo "Starting containers..."
	@$(COMPOSE) start
	@echo "Containers started."

restart: stop start
	@echo "Containers restarted."

clean: down delete_volume
	@echo "Cleaning up..."
	@docker rmi -f nginx:inception mariadb:inception wordpress:inception

re: clean build
	@echo "Complete rebuild finished."

.PHONY : all hostsed_add hostsed_rm up down du re clean stop start restart create_volume delete_volume
