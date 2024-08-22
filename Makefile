default:
	@echo 'Enter command'

start: \
	down \
	yii-migrate-down \
	git-pull \
	init-existing-project

up:
	docker compose up -d --build --remove-orphans

down:
	docker compose down -v --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose exec php-fpm composer i

yii-migrate:
	docker compose exec php-fpm php yii migrate --interactive=0

yii-migrate-down:
	docker compose run --rm php-fpm php yii migrate/down 99999 --interactive=0

yii-cache-flush-all:
	docker compose exec php-fpm php yii cache/flush-all

bash:
	docker compose exec php-fpm bash

init-existing-project: \
	up \
	composer-i \
	yii-migrate \
	yii-cache-flush-all \
	bash

# ----------------------------------------------------------------------------------------------------------------------

init: \
	down \
	up \
	create-project \
	configure-project \
	yii-migrate \
	clear-initialization-files \
	git-init \
	bash

create-project:
	docker compose exec php-fpm rm .gitkeep
	docker compose exec php-fpm composer create-project --no-interaction --prefer-dist yiisoft/yii2-app-basic .

configure-project:
	cp ./.docker/.helpers/configure-project.php ./app
	docker compose exec php-fpm php configure-project.php
	rm ./app/configure-project.php

clear-initialization-files:
	cp ./.docker/.helpers/clear-makefile.php ./app
	cp ./Makefile ./app/Makefile
	docker compose exec php-fpm php clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm ./app/clear-makefile.php
	rm -r ./.docker/.helpers
	echo '' > README.md

git-init:
	rm -fr .git
	git init
