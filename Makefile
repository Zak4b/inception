include srcs/.env

COMPOSE_FILE = srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)

all: create_volume  hostsed_add
	@$(COMPOSE) up --build -d

create_volume:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress_db
	@mkdir -p /home/$(USER)/data/wordpress

delete_volume:
	@sudo rm -rf /home/$(USER)/data/mariadb
	@sudo rm -rf /home/$(USER)/data/wordpress_db
	@sudo rm -rf /home/$(USER)/data/wordpress

check_hostsed:
	@dpkg -s hostsed >/dev/null 2>&1 || sudo apt update && sudo apt install -y hostsed

hostsed_add: check_hostsed
	@echo Added Host
	@sudo hostsed add 127.0.0.1 $(LOGIN).42.fr > /dev/null

hostsed_rm: check_hostsed
	@sudo hostsed rm 127.0.0.1 $(LOGIN).42.fr > /dev/null

up: create_volume hostsed_add
	@$(COMPOSE) up --detach

down:
	@$(COMPOSE) down

du: down up

stop:
	@$(COMPOSE) stop

start:
	@$(COMPOSE) start

restart: stop start

clean: down delete_volume
	@docker system prune --all --force

re: clean all

.PHONY : all hostsed_add hostsed_rm up down du re clean stop start restart create_volume delete_volume