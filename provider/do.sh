#!/bin/bash

trap exit SIGINT

function doaws() {
  aws --endpoint=https://nyc3.digitaloceanspaces.com $*
}

export AWS_ACCESS_KEY_ID=${DIGITALOCEAN_ACCESS_ID}
export AWS_SECRET_ACCESS_KEY=${DIGITALOCEAN_SECRET_KEY}

doctl auth init -t ${DIGITALOCEAN_TOKEN}

for id in $(doctl kubernetes cluster list -o json | jq -r '.[] | select(.name | startswith("ci-")) | .id'); do
  name=$(doctl kubernetes cluster get $id -o json | jq -r ".[0].name")
  echo "deleting cluster: $name"
  doctl kubernetes cluster delete $id -f
done

for id in $(doctl compute volume list -o json | jq -r '.[] | select((.droplet_ids | length) == 0) | .id'); do
  echo "deleting volume: $id"
  doctl compute volume delete $id -f
done

for bucket in $(doaws s3api list-buckets | jq -r '.Buckets[].Name | select(startswith("ci-"))'); do
  echo "deleting bucket: $bucket"
  doaws s3api delete-bucket --bucket $bucket
done