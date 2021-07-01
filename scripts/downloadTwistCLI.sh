#!/bin/bash -l

curl -s -k -u $PC_USER:$PC_PASS "https://$PC_CONSOLE/api/v1/util/twistcli" -v -o twistcli;chmod +x twistcli