FROM alpine:latest

COPY requirements.txt /
COPY builder /usr/local/bin/

RUN apk add --no-cache \
        python3 \
        py3-pip \
        rsync \
        openssh \
        git \
        bash \
      && \
    pip3 install -r /requirements.txt  && \
    mkdir -pv /project-root /my-theme && \
    git clone --recursive https://github.com/getpelican/pelican-plugins /pelican-plugins

VOLUME ["/project-root", "/theme"]
WORKDIR /project-root
CMD ["builder"]
