include srcs/.env

COMPOSE_FILE = srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)
DB_VOLUME = /home/$(USER)/data/mariadb
WP_VOLUME = /home/$(USER)/data/wordpress
VOLUMES = $(DB_VOLUME) $(WP_VOLUME)

R = \e[1;31m
J = \e[1;33m
V = \e[1;32m
D = \e[0m

all: build

create_volume:
	@id -u mysql >/dev/null 2>&1 || sudo useradd -r -s /usr/sbin/nologin mysql
	@echo "$(J)Creating local volumes...$(D)"
	@mkdir -p $(VOLUMES)
	@sudo chmod 777 $(VOLUMES)

delete_volume:
	@echo "$(R)Deleting local volumes...$(D)"
	@sudo rm -rf $(VOLUMES)

check_hostsed:
	@dpkg -s hostsed >/dev/null 2>&1 || (echo "$(J)hostsed not found, installing...$(D)" && sudo apt update && sudo apt install -y hostsed)

hostsed_add: check_hostsed
	@sudo hostsed add 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	@echo "$(J)$(DOMAIN_NAME) added to hosts.\e[0m"

hostsed_rm: check_hostsed
	@sudo hostsed rm 127.0.0.1 $(DOMAIN_NAME) > /dev/null
	@echo "$(R)$(DOMAIN_NAME) removed from hosts.$(D)"

build: hostsed_add create_volume
	@$(COMPOSE) up --build -d

up:
	@echo "$(J)Starting services...$(D)"
	@$(COMPOSE) up -d

down:
	@echo "$(J)Stopping services...$(D)"
	@$(COMPOSE) down

stop:
	@echo "$(J)Stopping services...$(D)"
	@$(COMPOSE) stop

start:
	@echo "$(J)Starting services...$(D)"
	@$(COMPOSE) start

restart: stop start

clean: down delete_volume hostsed_rm
	@echo "$(R)Cleaning up...$(D)"
	@docker rmi -f nginx:inception mariadb:inception wordpress:inception redis:inception vsftpd:inception

re: clean build
	@echo "$(V)Complete rebuild finished.$(D)"

.PHONY : all hostsed_add hostsed_rm up down du re clean stop start restart create_volume delete_volume
