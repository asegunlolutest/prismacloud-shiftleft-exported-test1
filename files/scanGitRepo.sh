#!/bin/bash -l
./twistcli coderepo scan --address $PC_CONSOLE -u $PCUSER -p $PCPASS --repository $REPO_ID ./
scandetails=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$REPO_ID"|jq '.[-1]')
scanresult=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/coderepos-ci?name=$REPO_ID"|jq '.[-1].pass')

if [ "$scanresult" == $PRE_BUILD_GIT_SCAN_FLAG ]; then
   echo "Code Repo scan passed!"
   exit 0
else
   echo "Code Repo scan failed!"
   echo $scandetails | jq
   exit 1
fi
