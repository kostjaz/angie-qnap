# angie-qnap

Минимальный Docker-стенд с `Angie` как reverse proxy.

## Что настроено

- скрытие версии сервера через `server_tokens off`
- default site на `80` и `443`
- для неизвестных `Host` запрос закрывается через `return 444`
- на `443` используется локальный self-signed сертификат для default vhost
- рабочие домены продолжают использовать ACME

## Структура

- `angie.conf` - основной конфиг `Angie`
- `http.d/default.conf` - default vhost для неизвестных `Host`
- `http.d/sites.conf.example` - пример конфигурации рабочих сайтов
- `http.d/upstreams.conf.example` - пример локальных upstream-адресов
- `http.d/proxy.conf` - общие proxy-заголовки
- `generate-default-cert.sh` - локальная генерация self-signed сертификата

## Быстрый старт

Сгенерировать локальный сертификат для default `443` vhost:

```sh
./generate-default-cert.sh
```

Подготовить локальные upstream-адреса:

```sh
cp http.d/upstreams.conf.example http.d/upstreams.conf
```

После этого отредактировать `http.d/upstreams.conf` под свою сеть.

Подготовить локальную конфигурацию сайтов:

```sh
cp http.d/sites.conf.example http.d/sites.conf
```

После этого отредактировать `http.d/sites.conf` под свои домены и маршруты.

Поднять контейнер:

```sh
docker compose up -d
```

Проверить конфигурацию:

```sh
docker compose exec angie angie -t
```

## Важно

Каталог `certs/` добавлен в `.gitignore` и не должен коммититься. Это не боевые сертификаты, но приватные ключи всё равно не стоит хранить в репозитории.

Файлы `http.d/upstreams.conf` и `http.d/sites.conf` тоже добавлены в `.gitignore`. В репозитории хранятся только `*.example`, чтобы не светить реальные внутренние IP, адреса и доменные имена.
