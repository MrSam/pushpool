#! /bin/sh
# /etc/init.d/bitpool: start and stop bitcoind and pushpool

set -e

test -x /usr/local/sbin/bitcoind || exit 0
test -x /usr/local/sbin/pushpoold || exit 0

BITCOIND_OPTS="-conf=/etc/bitcoin.conf -daemon"
PUSHPOOLD_OPTS="-c /etc/pushpoold.conf"

export PATH="${PATH:+$PATH:}/usr/sbin:/sbin:/usr/local/sbin"

case "$1" in
  start)
        echo -n "Starting bitcoind"
        /usr/local/sbin/bitcoind $BITCOIND_OPTS 2> /dev/null &
        echo "."

	sleep 2

        echo -n "Starting pushpoold"
        /usr/local/sbin/pushpoold $PUSHPOOLD_OPTS 2> /dev/null &
        echo "."

	sleep 2

        echo -n "Starting blkmond"
        /usr/local/sbin/blkmond > /dev/null 2>&1 &
        echo "."

        ;;
  stop)
        echo -n "Stopping bitcoind"
	/usr/local/sbin/bitcoind stop > /dev/null 2>&1 &
        echo "."

        echo -n "Stopping pushpoold"
        start-stop-daemon --stop --quiet --oknodo --pidfile /var/run/pushpoold.pid 2> /dev/null &
        echo "."

        echo -n "Stopping blkmond"
	pkill blkmond &
        echo "."
        ;;

  *)
        echo "Usage: /etc/init.d/bitpool {start|stop}"
        exit 1
esac

exit 0
