FROM debian
MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running Diamond Coin (DMD) wallet headless using docker container by http://bit.ly/docker-dmdcoin"

RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      curl ca-certificates git build-essential libssl-dev libcurl4-openssl-dev libboost1.55-all-dev libdb5.3++-dev libdb5.3-dev && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/dmdcoin/diamond.git /tmp/diamond
WORKDIR /tmp/diamond/src
RUN mkdir -p /tmp/diamond/src/obj && \
make -f makefile.unix USE_UPNP=- 
#&& \
#cp diamondd /usr/bin/diamondd && \
#rm -rf /tmp/diamond

ADD ./bin /usr/local/bin
RUN chmod a+x /usr/local/bin/*

ENV HOME /diamond
VOLUME ["/diamond"]
EXPOSE 17771 17772

WORKDIR /tmp/diamond/src

CMD ["oneshot"]
