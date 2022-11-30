FROM python:3-slim-bullseye

COPY requirements.txt /
COPY builder /usr/local/bin/

RUN apt-get update && \
    apt-get install -y --no-install-recommends git && \
    python3 -m pip install -r /requirements.txt  && \
    mkdir -pv /project-root /my-theme && \
    git clone --recursive https://github.com/getpelican/pelican-plugins /pelican-plugins

VOLUME ["/project-root", "/theme"]
WORKDIR /project-root
CMD ["builder"]
