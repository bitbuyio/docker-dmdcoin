FROM debian
MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running Diamond Coin (DMD) wallet headless using docker container by http://bit.ly/docker-dmdcoin"

RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      curl ca-certificates wget libboost-filesystem1.55.0 libboost-program-options1.55.0 \
      libboost-system1.55.0 libboost-thread1.55.0 libdb5.3++ && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/bitbuyio/docker-dmdcoin/releases/download/v2.0.5.7/diamondd && \
    mv diamondd /usr/local/bin/diamondd

ADD ./bin/oneshot /usr/local/bin
ADD ./bin/init_dmd /usr/local/bin
RUN chmod a+x /usr/local/bin/*

ENV HOME /diamond
VOLUME ["/diamond"]
EXPOSE 17771 17772

WORKDIR /diamond

CMD ["oneshot"]
