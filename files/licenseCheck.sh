#!/bin/bash -l

./twistcli coderepo scan --address https://$PC_CONSOLE -u $PCUSER -p $PCPASS ./license  
result=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "https://$PC_CONSOLE/api/v1/coderepos-ci?limit=1&reverse=true&sort=scanTime"|jq '.[0].pass')


if [ "$result" == "true" ]; then
   echo "License check passed!"
   exit 0
else
   echo "License check failed!"
   exit 1
fi
