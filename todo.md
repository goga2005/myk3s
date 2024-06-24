# How Install K3s with Calico eBPF

## Teorico de redes
- https://www.youtube.com/watch?v=NFApeJRXos4

## Docs
- https://docs.tigera.io/calico/latest/getting-started/kubernetes/k3s/quickstart

	Install Calico
	- kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml
	Add custom Resource (Alterar range de rede)
	- kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/custom-resources.yaml
	
	Configure Calico to access cluster api server (https://docs.tigera.io/calico/latest/operations/ebpf/enabling-ebpf#configure-calico-to-talk-directly-to-the-api-server)
	- kubectl apply -f /vagrant/configMap.yaml
	
	"VERIFICAR" Disable kupe-proxy (https://docs.tigera.io/calico/latest/operations/ebpf/enabling-ebpf#configure-kube-proxy)
	- kubectl patch ds -n kube-system kube-proxy -p '{"spec":{"template":{"spec":{"nodeSelector":{"non-calico": "true"}}}}}'
	
	Enable eBPF mode (https://docs.tigera.io/calico/latest/operations/ebpf/enabling-ebpf#enable-ebpf-mode)
	- kubectl patch installation.operator.tigera.io default --type merge -p '{"spec":{"calicoNetwork":{"linuxDataplane":"BPF"}}}'
	
	
	Instalando Traefik
	- helm repo add traefik https://traefik.github.io/charts
	- helm repo update
	- helm install -f /vagrant/traefik/values.yaml traefik traefik/traefik
	Configure Traefik
	- kubectl apply -f /vagrant/traefik/secret.yaml
	- kubectl apply -f /vagrant/traefik/ingress.yaml
	
	
	Instalando App Whoami
	- kubectl apply -f /vagrant/whoami/whoami.yml    
    
    
    
    
    
    
## History

    1  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/tigera-operator.yaml
    2  cd /vagrant/calico/
    3  kubectl apply -f custom-resources.yaml 
    4* kubectl cluster-inf
    5  kubectl apply -f configMap.yaml 
    6  watch kubectl get pods -n calico-system
    7  kubectl patch ds -n kube-system kube-proxy -p '{"spec":{"template":{"spec":{"nodeSelector":{"non-calico": "true"}}}}}'
    8  kubectl patch felixconfiguration default --patch='{"spec": {"bpfKubeProxyIptablesCleanupEnabled": false}}'
    9  helm repo add traefik https://traefik.github.io/charts
   10  helm repo update
   11  helm install traefik traefik/traefik
   12  cd ..
   13  cd hel
   14  cd traefik/
   15  kubectl apply -f helm-chart-config.yaml 
   16  helm install -f /vagrant/traefik/values.yaml traefik traefik/traefik
   17  kubectl apply -f ingress.yaml 
   18  kubectl apply -f tls-store.yaml 
   19  kubectl apply -f secret.yaml 
   20  kubectl apply -f /vagrant/whoami/whoami.yml
   21  helm upgrade --values values.yaml traefik traefik/traefik
   22  kubectl apply -f secret.yaml 
   23* kubectl apply -f tls-store.yaml
   24  kubectl apply -f ingress.yaml 
   25  history > /vagrant/todo.md
