# yii2-docker-nginx-fpm-mysql

- [Installation](#installation)

## Installation

- You can set environment variables in the `.env` file before initialization
- During installation, you will be required to enter a password to run some commands as superuser (see `Makefile`)

``` sh
git clone https://github.com/w3lifer/yii2-docker-nginx-fpm-mysql
make init
```

After installation the `.git` directory will be removed and the new repository will be initialized. You can add your remote:

``` sh
git remote add origin git@github.com:<user>/<repo>
```

To access the app, open http://localhost:88 in your favorite browser (see `.env` file)
