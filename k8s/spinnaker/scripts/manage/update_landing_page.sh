#!/usr/bin/env bash

bold() {
  echo ". $(tput bold)" "$*" "$(tput sgr0)";
}

source ~/scratch/scripts/install/properties

# Query for static ip address as a signal that the Spinnaker installation is exposed via a secured endpoint.
export IP_ADDR=$(gcloud compute addresses list --filter="name=$STATIC_IP_NAME" \
  --format="value(address)" --global --project $PROJECT_ID)

if [ -z "$IP_ADDR" ]; then
  bold "Updating Cloud Shell landing page for unsecured Spinnaker..."
  cat ~/scratch/scripts/manage/landing_page_base.md ~/scratch/scripts/manage/landing_page_unsecured.md \
    | envsubst > ~/scratch/scripts/manage/landing_page_expanded.md
else
  bold "Updating Cloud Shell landing page for secured Spinnaker..."
  cat ~/scratch/scripts/manage/landing_page_base.md ~/scratch/scripts/manage/landing_page_secured.md \
    | envsubst > ~/scratch/scripts/manage/landing_page_expanded.md
fi
