# Docker Diamond Coin (DMD) Daemon Headless
[![](https://badge.imagelayers.io/bitbuyio/neucoin:latest.svg)](https://imagelayers.io/?images=bitbuyio/neucoin:latest 'Get your own badge on imagelayers.io')

neucoin uses peer-to-peer technology to operate with no central authority or banks; managing transactions and the issuing of neucoin is carried out collectively by the network. neucoin is open-source; its design is public, nobody owns or controls neucoin and everyone can take part. Through many of its unique properties, neucoin allows exciting uses that could not be covered by any previous payment system.

**Usage**

To start a neucoind instance running the latest version (`1.2.0`):

```
$ docker run --name neucoin-node bitbuyio/neucoin
```

To run a neucoin container in the background, pass the `-d` option to `docker run`:

```
$ docker run -d --name neucoin-node bitbuyio/neucoin
```

Once you have a neucoin service running in the background, you can show running containers:

```
$ docker ps
```

Or view the logs of a service:

```
$ docker logs -f neucoin-node
```

To stop and restart a running container:

```
$ docker stop neucoin-node
$ docker start neucoin-node
```

To exec neucoind cmd into a running container:

```
$ docker exec -it neucoin-node neucoind getinfo
$ docker exec -it neucoin-node neucoind stop
```

**Data Volumes**

By default, Docker will create ephemeral containers. That is, the blockchain data will not be persisted if you create a new neucoin container.

To create a simple `busybox` data volume and link it to a neucoin service:

```
$ docker create -v /diamond --name=diamond-data busybox chown 1000:1000 /diamond
$ docker run --volumes-from diamond-data --name=diamond-node -d -p 17772:17772 -p 127.0.0.1:17771:17771 bitbuyio/diamond
$ docker run --volumes-from neucoin-data -v /vagrant/datahub/docker/backup/neucoin:/backup busybox tar cvf /backup/backup.tar /neucoin
$ docker run --volumes-from neucoin-backup busybox ls -al /backup/neucoin
$ docker run --volumes-from neudata -v $(pwd)/backup:/backup busybox tar xvf /backup/backup.tar
$ docker run --volumes-from neudata busybox ls -al /neucoin/.neucoin

```
