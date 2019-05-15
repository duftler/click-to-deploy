#!/usr/bin/env bash

HALYARD_POD=spin-halyard-0

kubectl exec $HALYARD_POD -n halyard -- bash -c 'hal deploy apply'

~/click-to-deploy/k8s/spinnaker/scripts/manage/deploy_application_manifest.sh
