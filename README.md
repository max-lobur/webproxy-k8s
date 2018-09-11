# Web Proxy on Kubernetes
A simple web proxy with basic auth, running on kubernetes. Based on Squid3.

## Deployment
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
   helm install charts/`ls charts/ | tail -1` --name webproxy-k8s --namespace=webproxy -f samples/high-avail.my.yaml --set login="$LOGIN"
   ```
1. Test
   ```bash
   curl -v -x usr:pwd@name.domain.io http://g.co/
   ```
1. Upgrading 
   ```bash
   helm upgrade webproxy-k8s charts/`ls charts/ | tail -1` -f samples/high-avail.my.yaml --set login="$LOGIN"
   ```
## Running the HA version in a multi-AZ cluster
Chart [deployment](./charts/webproxy/templates/deployment.yaml) has [soft anti-affinity](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) 
scheduling built-in. To get HA setup run it on a multi-node cluster and set replicas to >1.