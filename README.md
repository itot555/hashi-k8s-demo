# k8s consul/vault/transit-app/mariadb demo
Software requirements (on your laptop):

```git curl jq kubectl(v1.17 or greater) helm3 consul vault```

## Setup
0. Set your GCP creds. I've done mine via environment variables
https://www.terraform.io/docs/providers/google/provider_reference.html

If using TFE, use the GOOGLE_CREDENTIALS environment variable. Also the JSON credential data is required to all be on one line. Just modify in a text editor before adding to TFE.
```bash
GOOGLE_CREDENTIALS: {"type": "service_account","project_id": "klaas","private_key_id":.......... 
````
1. Fill out `variables.tf` with your values

2. plan/apply
```bash
terraform apply --auto-approve
```

3. Copy the command for  "connecting" to your k8s cluster from the terraform output.
```bash
gcloud container clusters get-credentials your-cluster-name --zone us-central1-c --project your-project
```

4. Deploy Consul/Vault/Mariadb/Python-transit-app. This takes a minute or two as there are a bunch of sleeps setup in the script.

Before deploying, confirm whether `consul` or `vault` are running in your local environment. If running, stop `consul` and `vault`.

```bash
cd demo
./full_stack_deploy.sh
```
cat that script if you want to see how to deploy each of the above by hand/manually.



## Teardown
```bash
demo/cleanup.sh
```

## UI
Refresh your browser tab when they initally open up. They are started by nohup commands using kubectl port-forward. see demo/vault/vault.sh and demo/consul/consul.sh
```bash
#Consul
http://localhost:8500

#Vault
http://localhost:8200
```

## Encryption as a service demo
Use the following command to access the application. Use port 5000.
```bash
$ kubectl get svc k8s-transit-app
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
k8s-transit-app   LoadBalancer   10.15.250.236   <pending>     5000:30549/TCP   11s

```

## Go Movies App Demo 
Blog post: [Medium.com link]
Use the following command to access the application. Use port 8080.
```bash
$ kubectl get svc go-movies-app
NAME              TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
go-movies-app   LoadBalancer   10.15.250.237   <pending>     8080:30539/TCP   11s

```



## Consul Ingress Gateway
The ingress gateway can be used to access either the k8s-transit-app (Vault features) or go-movies-app (Consul L7 features)
