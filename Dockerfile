FROM ubuntu:16.04
MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="running Diamond Coin (DMD) wallet headless using docker container by http://bit.ly/docker-dmdcoin"

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl ca-certificates wget software-properties-common libboost-all-dev && \
    add-apt-repository ppa:bitcoin/bitcoin && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y libdb4.8-dev libdb4.8++-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN cd /usr/local/bin && \
    wget https://github.com/DMDcoin/Diamond/releases/download/3.0.0.13/Linux.3-0-0-13.tar.gz && \
    tar -xzf Linux.3-0-0-13.tar.gz && \
    rm tar -xzf Linux.3-0-0-13.tar.gz

ADD ./bin/oneshot /usr/local/bin
ADD ./bin/init_dmd /usr/local/bin
RUN chmod a+x /usr/local/bin/*

ENV HOME /diamond
VOLUME ["/diamond"]
EXPOSE 17771 17772

WORKDIR /diamond

CMD ["oneshot"]
