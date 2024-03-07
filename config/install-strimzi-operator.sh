#!/bin/sh
SCRIPT_PATH=${0%/*}
if [ "$0" != "$SCRIPT_PATH" ] && [ "$SCRIPT_PATH" != "" ]; then
    cd "$SCRIPT_PATH" || exit
fi

git checkout strimzi-0.39.0
kubectl create namespace kafka -o yaml
sed -i 's/namespace: .*/namespace: kafka/' strimzi-0.39.0/install/cluster-operator/*RoleBinding*.yaml

kubectl create -f strimzi-0.39.0/install/cluster-operator -n kafka -o yaml
