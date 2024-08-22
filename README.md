# yii2-app-basic-docker

- [Initialization](#initialization)
- [Initializing an existing project](#initializing-an-existing-project)
- [Starting an existing project](#starting-an-existing-project)

## Initialization

``` sh
git clone https://gitlab.com/w3lifer/yii2-app-basic-docker yii2-app-basic
cd yii2-app-basic
```

> You can set environment variables in the [`.env`](.env) file

``` sh
make init
```

After this, the `.git` directory will be deleted and the new repository will be created

Hence, you can add your remote `origin` to the newly created repository, commit and push the initial commit:

``` sh
git remote add origin git@gitlab.com:<user>/<repo>
git add .
git commit -m 'initial commit'
git push -u origin master
```

To access the app, open http://localhost:800 (see [`.env`](.env) file)

## Initializing an existing project

``` sh
git clone git@gitlab.com:<user>/<repo>
cd <repo>
make init-existing-project
```

## Starting an existing project

``` sh
make start
```
