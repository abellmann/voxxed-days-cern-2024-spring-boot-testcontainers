#!/bin/sh
SCRIPT_PATH=${0%/*}
if [ "$0" != "$SCRIPT_PATH" ] && [ "$SCRIPT_PATH" != "" ]; then
    cd "$SCRIPT_PATH" || exit
fi

kubectl apply -f kourier.yaml -o yaml

kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --output yaml \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'
