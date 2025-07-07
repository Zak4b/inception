include srcs/.env

COMPOSE_FILE = srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)

all: create_volume  hostsed_add
	@echo "Starting all services..."
	@$(COMPOSE) up --build -d
	@echo "All services are up and running."

create_volume:
	@echo "Creating local volumes..."
	@mkdir -p /home/$(USER)/data/wordpress_db
	@mkdir -p /home/$(USER)/data/wordpress

delete_volume:
	@echo "Deleting local volumes..."
	@rm -rf /home/$(USER)/data/wordpress_db
	@rm -rf /home/$(USER)/data/wordpress

check_hostsed:
	@dpkg -s hostsed >/dev/null 2>&1 || (echo "hostsed not found, installing..." && sudo apt update && sudo apt install -y hostsed)

hostsed_add: check_hostsed
	@sudo hostsed add 127.0.0.1 $(DOMAIN) > /dev/null
	@echo "$(DOMAIN) added to hosts."

hostsed_rm: check_hostsed
	@sudo hostsed rm 127.0.0.1 $(DOMAIN) > /dev/null
	@echo "$(DOMAIN) removed from hosts."

up: create_volume hostsed_add
	@echo "Starting services..."
	@$(COMPOSE) up --detach

down:
	@echo "Stopping services..."
	@$(COMPOSE) down

du: down up
	@echo "Restarting services."

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
	@docker system prune --all --force

re: clean all
	@echo "Complete rebuild finished."

.PHONY : all hostsed_add hostsed_rm up down du re clean stop start restart create_volume delete_volume
