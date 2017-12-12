# Docker Diamond Coin (DMD) Daemon Headless
[![](https://badge.imagelayers.io/bitbuyio/diamond:latest.svg)](https://imagelayers.io/?images=bitbuyio/diamond:latest 'Get your own badge on imagelayers.io')

diamond uses peer-to-peer technology to operate with no central authority or banks; managing transactions and the issuing of diamond is carried out collectively by the network. diamond is open-source; its design is public, nobody owns or controls diamond and everyone can take part. Through many of its unique properties, diamond allows exciting uses that could not be covered by any previous payment system.

**Usage**

To start a diamondd instance running the latest version (`3.0.0.13`):

```
$ docker run --name=diamond-data -v /diamond alpine:latest chown 1000:1000 /diamond


$ docker run -d \
  --restart=always \
  --volumes-from diamond-data \
  --name diamond-node \
  -p 17771:17771 \
  -p 17772:17772 \
  bitbuyio/diamond
```

To run a diamond container in the background, pass the `-d` option to `docker run`:

```
$ docker run -d --volumes-from diamond-data  -p 17771:17771 -p 17772:17772 --name diamond-node bitbuyio/diamond
```

Once you have a diamond service running in the background, you can show running containers:

```
$ docker ps
```

Or view the logs of a service:

```
$ docker logs -f diamond-node
```

To stop and restart a running container:

```
$ docker stop diamond-node
$ docker start diamond-node
```

To exec diamondd cmd into a running container:

```
$ docker exec -it diamond-node diamondd getinfo
$ docker exec -it diamond-node diamondd stop
```

**Data Volumes**

By default, Docker will create ephemeral containers. That is, the blockchain data will not be persisted if you create a new diamond container.

To create a simple `busybox` data volume and link it to a diamond service:

```
$ docker create -v /diamond --name=diamond-data busybox chown 1000:1000 /diamond
$ docker run --volumes-from diamond-data --name=diamond-node -d -p 17772:17772 -p 127.0.0.1:17771:17771 bitbuyio/diamond
$ docker run --volumes-from diamond-data -v /vagrant/datahub/docker/backup/diamond:/backup busybox tar cvf /backup/backup.tar /diamond
$ docker run --volumes-from diamond-backup busybox ls -al /backup/diamond
$ docker run --volumes-from neudata -v $(pwd)/backup:/backup busybox tar xvf /backup/backup.tar
$ docker run --volumes-from neudata busybox ls -al /diamond/.diamond

```
