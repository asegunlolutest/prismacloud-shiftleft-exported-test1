#!/bin/bash -l

vulnresult=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/registry?id=$ACR_FQDN/$IMAGE_NAME&limit=1&reverse=true&sort=scanTime"|jq '.[-1].vulnerabilitiesCount')

complianceresult=$(curl -k -u $PCUSER:$PCPASS -H 'Content-Type: application/json' "$PC_CONSOLE/api/v1/registry?id=$ACR_FQDN/$IMAGE_NAME&limit=1&reverse=true&sort=scanTime"|jq '.[-1].complianceIssuesCount')

if [[ "$vulnresult" == "0" ]] && [[ "$complianceresult" == "0" ]]; then
   echo "Registry Image scan passed!"
   exit 0
else
   echo "Registry Image scan failed!"
   echo $vulnresult "vulnerability issues found!"
   echo $complianceresult "compliance issues found!"
   exit $PRE_DEPLOY_REG_SCAN_FLAG
fi