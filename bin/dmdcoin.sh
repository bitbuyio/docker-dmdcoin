#!/bin/sh
# `/sbin/setuser memcache` runs the given command as the user `memcache`.
# If you omit that part, the command will be run as root.
# exec /usr/local/bin/start >>/var/log/dmdcoin.log 2>&1

set -ex

# Generate diamond.conf
if [ ! -e "$HOME/.DMDV3/diamond.conf" ]; then
    mkdir -p $HOME/.DMDV3

    echo "Creating diamond.conf"

    # Seed a random password for JSON RPC server
    cat <<EOF > $HOME/.DMDV3/diamond.conf

dbcache=100
detachdb=1

rpcuser=diamondrpc
rpcpassword=$(dd if=/dev/urandom bs=33 count=1 status=none | base64)
rpcport=17771
rpcconnect=127.0.0.1
#rpcallowip=*

listen=0
daemon=1
server=1
noirc=1

bantime=3600
EOF

fi

cat $HOME/.DMDV3/diamond.conf

echo "Initialization completed successfully"

exec /sbin/setuser dmdcoin /usr/local/bin/diamondd >>/var/log/dmdcoin.log 2>&1
