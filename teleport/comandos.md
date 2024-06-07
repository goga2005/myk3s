helm install teleport-cluster teleport/teleport-cluster --create-namespace --version 15.4.0 --values teleport/teleport-cluster-values.yaml

--

# Criando User

kubectl exec -i -n teleport-cluster deployment/teleport-cluster-auth -- tctl create -f < teleport/member.yaml

kubectl exec -ti deployment/teleport-cluster-auth -- tctl users add admin --roles=member,access,editor