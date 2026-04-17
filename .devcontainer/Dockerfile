FROM docker.io/rocker/r-ver:4.5.0

ENV DEBIAN_FRONTEND=noninteractive

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
      build-essential \
      ca-certificates \
      curl \
      fonts-dejavu-core \
      git \
      libcairo2-dev \
      libcurl4-openssl-dev \
      libfontconfig1-dev \
      libfreetype6-dev \
      libfribidi-dev \
      libharfbuzz-dev \
      libjpeg-dev \
      libpng-dev \
      libssl-dev \
      libtiff5-dev \
      libuv1-dev \
      libxml2-dev \
      make \
      pandoc \
      pkg-config; \
    rm -rf /var/lib/apt/lists/*

    WORKDIR /workspaces/tidplotR