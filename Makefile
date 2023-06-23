default:
	@echo 'Enter command'

start-prod: down git-pull up composer-i yii-migrate
start-dev: start-prod

down:
	docker compose down -v --remove-orphans

up:
	docker compose up -d --build --remove-orphans

git-pull:
	git pull

composer-i:
	docker compose exec php-fpm composer i

composer-u:
	docker compose exec php-fpm composer u

yii-migrate:
	docker compose exec php-fpm php yii migrate --interactive=0

bash:
	docker compose exec php-fpm bash

# ----------------------------------------------------------------------------------------------------------------------

init: down up __create-project __change-config yii-migrate __clear __git-operations

__create-project:
	docker compose exec php-fpm rm .gitkeep
	docker compose exec php-fpm composer create-project --no-interaction --prefer-dist yiisoft/yii2-app-basic .

__change-config:
	cp ./.docker/.helpers/change-config.php ./app
	docker compose exec php-fpm php change-config.php
	rm ./app/change-config.php

__clear:
	cp ./.docker/.helpers/clear-makefile.php ./app
	cp ./Makefile ./app/Makefile
	docker compose exec php-fpm php clear-makefile.php
	mv ./app/Makefile ./Makefile
	rm ./app/clear-makefile.php
	rm -r ./.docker/.helpers

__git-operations:
	rm -fr .git
	git init
