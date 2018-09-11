# Web Proxy on Kubernetes
A simple web proxy with basic auth, running on kubernetes. Based on Squid3.

## Deployment
1. Add helm repo
   ```bash
   helm repo add webproxy-k8s https://raw.githubusercontent.com/max-lobur/webproxy-k8s/master/charts/
   ```
1. Generate squid basic auth login
   ```bash
   LOGIN=`htpasswd -nd <user>`
   echo $LOGIN
   ```
1. Edit sample vars
   ```bash
   cp ./samples/high-avail{,.my}.yaml
   open ./samples/high-avail.my.yaml
   ```
1. Deploy
   ```bash
   helm install webproxy-k8s/webproxy --name webproxy-k8s --namespace=webproxy -f samples/high-avail.my.yaml --set login="$LOGIN"
   ```
1. Test
   ```bash
   curl -v -x https://$LOGIN@webproxy.DOMAIN http://g.co/
   ```
## Running the HA version in a multi-AZ cluster
Chart [deployment](./charts/webproxy/templates/deployment.yaml) has [soft anti-affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) 
scheduling built-in. To get HA setup run it on a multi-node cluster and set replicas to >1.