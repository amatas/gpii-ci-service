#!/bin/bash

function cleanup {
  rm -f $LOCK
}

trap cleanup EXIT
trap cleanup INT

DEST=/var/lib/jenkins/static_dashboard
LOG=/tmp/jenkins_wget.log
URL=https://ci-int.gpii.net
LOCK=/tmp/jenkins_wget.lock
WAIT=10


# Exit if already running
[ -f $LOCK ] && exit 0

# Create lock
touch $LOCK

# Give Jenkins some time to update the front page
sleep $WAIT

wget  --no-check-certificate --recursive --level=3 --reject-regex "/config.xml|/build|/buildWithParameters|/polling|/job/.*/build" --accept-regex "/static/.*|/adjuncts/.*|/job/.*|/view/.*" --adjust-extension --convert-links -e robots=off -P $DEST $URL > $LOG 2>&1

date | tee $DEST/ci-int.gpii.net/timestamp.txt

exit 0
