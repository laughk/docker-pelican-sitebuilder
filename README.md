# docker-sitebuild-by-pelican

Docker container include [pelican](https://github.com/getpelican/pelican), [pelican-plugins](https://github.com/getpelican/pelican-plugins)

## use case

### build pelican site in localmachine

put `docker-compose.yml` like below to your pelican site project root directory.

```yml
version: '3'
services:
  pelican-sitebuild:
    image: laughk/sitebuild-by-pelican
    volumes:
      - .:/sitesrc
      - /path/to/pelican-theme-which-you-want:/theme
```

and execute below command.


```
docker-compose run pelican-sitebuild
```

then, static site contents will be generated to `output` directory.

If you want use `publishconf.py`, execute docker-compose with `-c` or `--config-type` option like below.

```
docker-compose run pelican-sitebuild -c publish
```
