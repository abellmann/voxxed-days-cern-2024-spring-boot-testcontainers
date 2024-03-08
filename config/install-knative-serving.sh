#!/bin/sh
SCRIPT_PATH=${0%/*}
if [ "$0" != "$SCRIPT_PATH" ] && [ "$SCRIPT_PATH" != "" ]; then
    cd "$SCRIPT_PATH" || exit
fi

# verify signing images

curl -sSL https://github.com/knative/serving/releases/download/knative-v1.10.1/serving-core.yaml \
  | grep 'gcr.io/' | awk '{print $2}' | sort | uniq \
  | xargs -n 1 \
    cosign verify -o text \
      --certificate-identity=signer@knative-releases.iam.gserviceaccount.com \
      --certificate-oidc-issuer=https://accounts.google.com

# install knative serving crds
kubectl apply -f ./knative-1.13.1/install/serving-crds.yaml -o yaml
# install knative serving core components
kubectl apply -f ./knative-1.13.1/install/serving-core.yaml -o yaml
# install networking layer
kubectl apply -f ./knative-1.13.1/install/kourier.yaml -o yaml
# configure knative to use kourier networking
kubectl patch configmap/config-network \
  --namespace knative-serving \
  --type merge \
  --output='yaml' \
  --patch '{"data":{"ingress-class":"kourier.ingress.networking.knative.dev"}}'

