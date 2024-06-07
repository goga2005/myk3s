kubectl apply -f maria/pv.yaml
kubectl apply -f maria/pvc.yaml

kubectl apply -f maria/mariadb-statefulset.yaml