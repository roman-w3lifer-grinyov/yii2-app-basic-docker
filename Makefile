default:
	@echo 'Enter command'

# ----------------------------------------------------------------------------------------------------------------------

init: down up __create-project __change-permissions __change-config __git-operations yii-migrate

update: git-pull composer-i yii-migrate

# ----------------------------------------------------------------------------------------------------------------------

down:
	docker compose down -v --remove-orphans

up:
	docker compose up -d --build --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose run --rm php-fpm composer i

composer-u:
	docker compose run --rm php-fpm composer u

yii-migrate:
	docker compose run --rm php-fpm php yii migrate --interactive=0

# ----------------------------------------------------------------------------------------------------------------------

__create-project:
	docker compose run --rm php-fpm composer create-project -n --prefer-dist yiisoft/yii2-app-basic .

__change-permissions:
	sudo chown -R ${USER}:root app

__change-config:
	cp ./.docker/.helpers/change-config.php ./app
	docker compose run --rm php-fpm php change-config.php
	rm ./app/change-config.php

__git-operations:
	rm -fr .git
	git init

# ----------------------------------------------------------------------------------------------------------------------
