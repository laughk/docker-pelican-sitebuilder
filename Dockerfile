FROM python:3-trixie

COPY requirements.txt /
COPY builder /usr/local/bin/

RUN python -m pip install -r requirements.txt && \
    mkdir -pv /project-root /my-theme && \
    git clone --recursive https://github.com/getpelican/pelican-plugins /pelican-plugins

VOLUME ["/project-root", "/theme"]
WORKDIR /project-root
CMD ["builder"]
