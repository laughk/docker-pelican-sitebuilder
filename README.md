# docker-sitebuild-by-pelican

Docker container include [pelican](https://github.com/getpelican/pelican), [pelican-plugins](https://github.com/getpelican/pelican-plugins), [getpelican/pelican-themes](https://github.com/getpelican/pelican-themes)

## use case

### build pelican site in localmachine

put `docker-compose.yml` like below to your pelican site project root directory.

```yml
version: '3'
services:
  pelican-sitebuilder:
    image: laughk/pelican-sitebuilder
    volumes:
      - .:/project-root
```

and execute below command.

```
docker-compose run pelican-sitebuilder
```

then, static site contents will be generated to `output` directory with using `pelicanconf.py`.

#### use with publishconf.py

If you want use `publishconf.py`, update docker-compose.yml to like below.

```yml
version: '3'
services:
  pelican-sitebuilder:
    image: laughk/pelican-sitebuilder
    volumes:
      - .:/project-root
    command: builder -c publish
```

#### use theme you want use

If you want use `publishconf.py`, update docker-compose.yml to like below.

```yml
version: '3'
services:
  pelican-sitebuilder:
    image: laughk/pelican-sitebuilder
    volumes:
      - .:/project-root
      - /path/to/pelican-theme-which-you-want:/my-theme
    command: builder -T
```

