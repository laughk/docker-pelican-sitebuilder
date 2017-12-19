FROM alpine:latest

ENV ALPINE_PACKAGES="\
      python3 \
      rsync \
      openssh \
      git \
      bash \
    "

ENV PY_PACKAGES="\
      pelican \
      markdown \
    "

RUN echo && \
      apk add --no-cache $ALPINE_PACKAGES && \
      pip3 install -U pip && \
      pip3 install $PY_PACKAGES && \
      mkdir -pv /sitesrc /theme && \
      git clone --recursive https://github.com/getpelican/pelican-plugins /pelican-plugins

COPY pelican-site-build.sh /usr/local/bin/
VOLUME ["/sitesrc", "/theme"]
WORKDIR /sitesrc
ENTRYPOINT ["/usr/local/bin/pelican-site-build.sh"]
