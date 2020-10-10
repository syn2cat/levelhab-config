#!/bin/bash
set -x
exec >>/tmp/c.log
exec 2>&1
if [ "$1" = "" ] || ( [ "$1" != "open" ] && [ "$1" != "closed" ] )
then
  echo "usage: $0 {open|closed}"
  exit 1
fi
spaceapikey="$(cat "$(dirname $0)"/spaceapikey.txt)"
nai=$(date +%s)
case "$1" in 
    "open" )
       openstate="true"
       ;;
    "closed" ) 
       openstate="false"
       ;;
   * ) echo "error"
       exit
       ;;
esac
/usr/bin/curl --max-time 3 --silent --data key="$spaceapikey" --data-urlencode sensors='{"state":{"open":'"$openstate"',"lastchange":'"$nai"'}}' https://spaceapi.syn2cat.lu/sensor/set

