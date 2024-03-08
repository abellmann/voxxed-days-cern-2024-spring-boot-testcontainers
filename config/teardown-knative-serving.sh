# uninstall kourier networking
kubectl delete --ignore-not-found -f https://github.com/knative/net-kourier/releases/download/knative-v1.13.0/kourier.yaml

# uninstall core components
kubectl delete --ignore-not-found -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-core.yaml

# uninstall crds
kubectl delete --ignore-not-found -f https://github.com/knative/serving/releases/download/knative-v1.13.1/serving-crds.yaml
