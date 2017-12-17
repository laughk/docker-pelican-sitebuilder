FROM alpine:latest

ENV ALPINE_PACKAGES="\
      python3 \
      rsync \
      openssh \
      git \
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

COPY buildconfig.py /
VOLUME ["/sitesrc", "/theme"]
WORKDIR /sitesrc
CMD ["pelican" , "/sitesrc/content", "--settings", "/buildconfig.py"]
