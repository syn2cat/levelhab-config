#!/bin/bash
set -x
exec >>/tmp/c.log
exec 2>&1
if [ "$1" = "" ]
then
  echo "usage: $0 number"
  exit 1
fi
spaceapikey="$(cat "$(dirname $0)"/spaceapikey.txt)"
presency="$1"
/usr/bin/curl --max-time 1 --silent --data key="$spaceapikey" --data-urlencode sensors='{"sensors":{"people_now_present":[{"value":'"$presency"'}]}}' https://spaceapi.syn2cat.lu/sensor/set

