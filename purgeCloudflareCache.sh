#!/bin/env bash

ZINEID=""
EMAIL=""
KEY=""

while getopts "z:e:k:" opt; do
  case $opt in
    z)
      ZINEID="$OPTARG"
      ;;
    k)
      KEY="$OPTARG"
      ;;
    e)
      EMAIL="$OPTARG"
      ;;
    ?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

if [ -z "$ZINEID" ]; then
  echo "-z option must be provided:" >&2
  exit 1
fi

if [ -z "$EMAIL" ]; then
  echo "-e option must be provided:" >&2
  exit 1
fi

if [ -z "$KEY" ]; then
  echo "-k option must be provided:" >&2
  exit 1
fi

curl --request POST \
  --url https://api.cloudflare.com/client/v4/zones/$ZINEID/purge_cache \
  --header 'Content-Type: application/json' \
  --header "X-Auth-Email: $EMAIL" \
  --header "X-Auth-Key: $KEY" \
  --data '{"purge_everything":true}'
