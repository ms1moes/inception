all: build

build:
	docker-compose -f srcs/docker-compose.yml up --build -d

stop:
	docker-compose -f srcs/docker-compose.yml stop
	
start:
	docker-compose -f srcs/docker-compose.yml start

remove:
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes

#only if need full reset
prune:
	sudo rm -rf /home/learodri/data/mariadb/*
	sudo rm -rf /home/learodri/data/wordpress/*
	docker-compose -f srcs/docker-compose.yml down --rmi all --volumes
	docker system prune -a --volumes --force

re: remove build

.PHONY: all build stop start remove re prune