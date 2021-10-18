FROM alpine:3.14.2

LABEL maintainer="mail@nguyenonline.com"

RUN apk update && \
  apk upgrade && \
  apk --no-cache add wget tar make gcc build-base gnupg perl

WORKDIR /tmp/texlive

COPY texlive.profile .

RUN wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz && \
  tar --strip-components=1 -xvf install-tl-unx.tar.gz && \
  ./install-tl --profile=texlive.profile

ENV PATH "$PATH:/usr/local/texlive/bin/x86_64-linuxmusl"
RUN tlmgr update --self --all

ENV DIR /work
WORKDIR $DIR

RUN rm -rf /tmp/texlive
