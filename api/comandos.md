vagrant ssh k3s_control_plane
cd /vagrant
helm install -f /home/rodrigocamargo/api/environment/development.values.yaml api ./api --namespace api --create-namespace --dry-run --debug
helm install -f /vagrant/api/environment/development.values.yaml api ./api --namespace api --create-namespace
helm upgrade --install --values /vagrant/api/environment/development.values.yaml api ./api --namespace api --create-namespace
helm uninstall api --namespace api