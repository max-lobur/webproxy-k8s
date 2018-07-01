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
   cp ./samples/ha-with-nginx-ingress{,.my}.yaml
   open ./samples/ha-with-nginx-ingress.my.yaml
   ```
1. Deploy
   ```bash
   helm install webproxy-k8s/webproxy --name webproxy-k8s --namespace=webproxy -f samples/ha-with-nginx-ingress.my.yaml --set login="$LOGIN"
   ```
1. Test
   ```bash
   curl -v -x $LOGIN@webproxy.DOMAIN:9999 http://g.co/
   ```
## Running the HA version in a multi-AZ cluster
The above example vars [ha-with-nginx-ingress.yaml](./samples/ha-with-nginx-ingress.yaml) have soft anti-affinity scheduling 
based on `failure-domain.beta.kubernetes.io/zone` node tag. See [Docs](https://kubernetes.io/docs/concepts/configuration/assign-pod-node/#affinity-and-anti-affinity) for details.