#!/bin/bash

curl -k -u $PCUSER:$PCPASS --output ./twistcli $PC_CONSOLE/api/v1/util/twistcli
chmod a+x ./twistcli

# Scan image
./twistcli images scan "$CONTAINER_REGISTRY/$IMAGE_NAME" --address $PC_CONSOLE -u $PCUSER -p $PCPASS

# Check result
scanresult=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/scans?type=ciImage&image=$IMAGE_NAME&reverse=true&sort=time&limit=1" | jq '.[-1].pass')

if [ "$scanresult" == $BUILD_IMAGE_SCAN_FLAG ]; then
   echo "Image scan passed!"
   exit 0
else
   echo "Image scan failed!"
   ./twistcli images scan "$CONTAINER_REGISTRY/$IMAGE_NAME" --address $PC_CONSOLE -u $PCUSER -p $PCPASS --details
   exit 1
fi

 
