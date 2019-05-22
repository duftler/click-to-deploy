#!/usr/bin/env bash

bold() {
  echo ". $(tput bold)" "$*" "$(tput sgr0)";
}

source ~/click-to-deploy/k8s/spinnaker/scripts/install/properties

bold "Updating Spinnaker to version $SPINNAKER_VERSION..."

~/hal/hal config version edit --version $SPINNAKER_VERSION
~/click-to-deploy/k8s/spinnaker/scripts/manage/push_config.sh
~/click-to-deploy/k8s/spinnaker/scripts/manage/apply_config.sh
~/click-to-deploy/k8s/spinnaker/scripts/manage/update_landing_page.sh