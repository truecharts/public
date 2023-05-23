# Installation Notes

Generate a cypher key for `App Key` like so.

Click the 3 dot and enter the app shell(select the correct pod).

temp create a .env file by running this command.

```shell
  echo 'APP_KEY=' >> .env
```

Generate the key and it will save it in the .env file.

```shell
php artisan key:generate --force
```

read the file into shell.

```shell
cat .env
```

copy the contents of the output after **APP_KEY=**.

edit the app again and add the contents to  App Key in the web gui for servas.

restart the app and access it here to create a account -> <http://truenas.local:11080/register>.
