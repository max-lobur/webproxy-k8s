# Web Proxy on Kubernetes
A simple web proxy with basic auth, running on kubernetes. Based on Squid3.

#### Deployment
1. Generate `passwords` file
   ```bash
   htpasswd -cd passwords <user>
   # Type password in a prompt
   cat passwords
   ```
1. Update `htpasswd` section in ConfigMap in yml
1. Deploy
   ```bash
   kubectl apply -f ./webproxy.yml
   ```
1. Test
   ```bash
   curl -v -x user:passwd@balancer_url:9999 http://g.co/
   ```
#### Running the HA version in a multi-AZ cluster
The `webproxy-ha.yml` has anti-affinity scheduling based on 
`failure-domain.beta.kubernetes.io/zone` node tag. To use it run the HA yml:
   ```bash
   kubectl apply -f ./webproxy-ha.yml
   ```
Check the replicas are deployed on different nodes:
   ```bash
   kc -n webproxy get po -owide
   ```