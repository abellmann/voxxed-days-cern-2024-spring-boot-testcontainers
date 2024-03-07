#!/bin/sh
git checkout .
kubectl create namespace kafka
sed -i 's/namespace: .*/namespace: kafka/' strimzi-0.39.0/install/cluster-operator/*RoleBinding*.yaml

kubectl create -f strimzi-0.39.0/install/cluster-operator -n kafka
