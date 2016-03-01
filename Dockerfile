
# FROM debian:jessie-backports
FROM ubuntu
MAINTAINER BitBuyIO <developer@bitbuy.io>
LABEL description="runing minergate console in docker by http://bit.ly/docker-minergate"

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get update && \
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils && \
#    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    curl ca-certificates build-essential git gcc g++ make libboost-system-dev libboost-filesystem-dev \
    libboost-program-options-dev libboost-thread-dev libdb++-dev libssl-dev libqrencode-dev \
    libpng-dev qt5-default qttools5-dev-tools pkg-config && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SOURCE https://github.com/neucoin/neucoin
ENV BRANCH master
#ENV ALGO cryptolight
#ENV USER miner@bitbuy.io
#ENV PASS x
#ENV URL stratum+tcp://bcn.pool.minergate.com:45550

RUN git config --global http.sslVerify false && \
    git clone $SOURCE && \
    cd /neucoin && \
    git checkout $BRANCH

WORKDIR /neucoin/src

RUN make -f Makefile.unix && \
    strip -s neucoind


ENV HOME /neu
VOLUME ["/neu"]
EXPOSE 7742 7743

WORKDIR /neucoin/src

ENTRYPOINT ./neucoind
