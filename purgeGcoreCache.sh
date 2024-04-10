#!/bin/env bash

API_KEY=""
ZONE_ID=""
while getopts "z:e:k:" opt; do
  case $opt in
    z)
      ZONE_ID="$OPTARG"
      ;;
    k)
      API_KEY="$OPTARG"
      ;;
    ?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "$ZONE_ID" ]; then
  echo "-z option must be provided:" >&2
  exit 1
fi

if [ -z "$API_KEY" ]; then
  echo "-k option must be provided:" >&2
  exit 1
fi

curl --request POST \
  --url https://api.gcore.com/cdn/resources/$ZONE_ID/purge \
  --header "Authorization: APIKey $API_KEY" \
  --header 'content-type: application/json' \
  --data '{"paths":["*"]}'