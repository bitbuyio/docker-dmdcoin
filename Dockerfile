FROM debian
MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running Diamond Coin (DMD) wallet headless using docker container by http://bit.ly/docker-dmdcoin"

RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      curl ca-certificates git build-essential libcurl4-openssl-dev libboost1.55-all-dev libdb5.3++-dev libdb5.3-dev && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/dmdcoin/diamond.git /usr/src/diamond
WORKDIR /usr/src/diamond/src
RUN mkdir -p /usr/src/diamond/src/obj && \
make -f makefile.unix USE_UPNP=- && \
cp diamondd /usr/bin && \
rm -rf /usr/src/diamond

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

ENV HOME /diamond
VOLUME ["/diamond"]
EXPOSE 17771 17772

WORKDIR /diamond

CMD ["oneshot"]
