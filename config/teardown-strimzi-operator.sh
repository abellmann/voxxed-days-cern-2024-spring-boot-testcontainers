#!/bin/sh
git checkout .
sed -i 's/namespace: .*/namespace: kafka/' strimzi-0.39.0/install/cluster-operator/*RoleBinding*.yaml

kubectl delete -f strimzi-0.39.0/install/cluster-operator -n kafka
kubectl delete namespace kafka
