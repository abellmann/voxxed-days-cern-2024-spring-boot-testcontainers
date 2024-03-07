#!/bin/sh
SCRIPT_PATH=${0%/*}
if [ "$0" != "$SCRIPT_PATH" ] && [ "$SCRIPT_PATH" != "" ]; then
    cd "$SCRIPT_PATH" || exit
fi
git checkout .
sed -i 's/namespace: .*/namespace: kafka/' strimzi-0.39.0/install/cluster-operator/*RoleBinding*.yaml

kubectl delete --ignore-not-found -f strimzi-0.39.0/install/cluster-operator -n kafka
kubectl delete --ignore-not-found namespace kafka
