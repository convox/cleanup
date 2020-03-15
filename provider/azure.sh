#!/bin/bash

trap exit SIGINT

az login --service-principal --username $ARM_CLIENT_ID --password $ARM_CLIENT_SECRET --tenant $ARM_TENANT_ID

for group in $(az group list --query "[?starts_with(name,'ci-')].name" -o tsv); do
  echo "deleting resource group: $group"
  az group delete --name $group --yes
done
