#!/bin/sh
SCRIPT_PATH=${0%/*}
if [ "$0" != "$SCRIPT_PATH" ] && [ "$SCRIPT_PATH" != "" ]; then
    cd "$SCRIPT_PATH" || exit
fi

# uninstall kourier networking
kubectl delete --ignore-not-found -f ./knative-1.13.1/install/kourier.yaml

# uninstall core components
kubectl delete --ignore-not-found -f ./knative-1.13.1/install/serving-core.yaml

# uninstall crds
kubectl delete --ignore-not-found -f ./knative-1.13.1/install/serving-crds.yaml
