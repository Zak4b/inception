COMPOSE_FILE = srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)
LOGIN = asene

create_volume:
	@mkdir -p /home/$(USER)/data/mariadb
	@mkdir -p /home/$(USER)/data/wordpress_db
	@mkdir -p /home/$(USER)/data/wordpress

check_hostsed:
	@dpkg -s hostsed >/dev/null 2>&1 || sudo apt update && sudo apt install -y hostsed

hostsed_add: check_hostsed
	@sudo hostsed add 127.0.0.1 $(LOGIN).42.fr > /dev/null

hostsed_rm: check_hostsed
	@sudo hostsed rm 127.0.0.1 $(LOGIN).42.fr > /dev/null

all: create_volume  hostsed_add
	@$(COMPOSE) up --build -d

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

re: clean all

prod: down delete_volume up

clean: down delete_volume
	@docker system prune --all --force

delete_volume:
	@sudo rm -rf /home/$(USER)/data/mariadb
	@sudo rm -rf /home/$(USER)/data/wordpress
	@sudo rm -rf /home/$(USER)/data/static_website_volume

.PHONY : all up down du re prod clean stop start restart create_volume delete_volume