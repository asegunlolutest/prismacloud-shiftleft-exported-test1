#!/bin/bash
curl -s -k -u $PCUSER:$PCPASS $PC_CONSOLE/api/v1/util/twistcli -v -o twistcli;chmod +x twistcli
