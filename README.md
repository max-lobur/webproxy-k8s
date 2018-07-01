# Web Proxy on Kubernetes
A simple web proxy with basic auth, running on kubernetes. Based on Squid3.

#### Deployment
1. Add helm repo to your cluster
   ```bash
   helm repo add webproxy https://raw.githubusercontent.com/max-lobur/webproxy-k8s/master/charts/
   ```
1. Generate squid basic auth login
   ```bash
   LOGIN=`htpasswd -nd <USER>`
   echo $LOGIN
   ```
1. Deploy (check ./samples)
   ```bash
   helm install webproxy-k8s -f ./samples/ha-with-nginx-ingress.yml --set 
   ```
1. Test
   ```bash
   curl -v -x user:passwd@balancer_url:9999 http://g.co/
   ```
#### Running the HA version in a multi-AZ cluster
The `webproxy-ha.yml` has anti-affinity scheduling based on 
`failure-domain.beta.kubernetes.io/zone` node tag. To use it 