FROM debian
MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running neucoin wallet headless using docker container by http://bit.ly/docker-neucoin"

RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      curl ca-certificates wget libboost-filesystem1.55.0 libboost-program-options1.55.0 \
      libboost-system1.55.0 libboost-thread1.55.0 libdb5.3++ && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://github.com/NeuCoin/neucoin/releases/download/v1.2.0/neucoind_1.2.0_debian_amd64.deb && \
    dpkg -i neucoind_1.2.0_debian_amd64.deb  && \
    rm neucoind_1.2.0_debian_amd64.deb

ADD ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/*

ENV HOME /neucoin
VOLUME ["/neucoin"]
EXPOSE 7742 7743

WORKDIR /neucoin

CMD ["oneshot"]
