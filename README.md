#  kops
### create R53 zone
    ID=$(uuidgen) && aws route53 create-hosted-zone # name bitcorn.site # caller-reference $ID | jq .DelegationSet.NameServers

### create S3 bucket
    export KSS=s3://kube-io-234212
    aws s3 mb s3://kube-io-234212

### upload local publiic key to cluster nodes
    kops create secret # name bitcorn.site sshpublickey admin -i ~/.ssh/id_rsa.pub # state s3://kube-io-234212

### Create cluster on aws
    kops create cluster # name  c1.bitcorn.site # zones us-east-2b # state s3://kube-io-234212 # yes # dns-zone bitcorn.site # node-count 2 # node-size t2.micro # master-size t2.micro # yes 
    kops update cluster bitcorn.site  # state s3://kube-io-234212 # yes

### Update Kube Cluster config
    kops edit cluster c1.bitcorn.site # state ${KSS}
    kops update cluster c1.bitcorn.site # state ${KSS} # yes

### Update Kube nodes config
     kops edit ig nodes # state ${KSS}

### Delete cluster
     kops delete cluster  # state s3://kube-io-234212 # name  c1.bitcorn.site

### Get cluster
     kops get cluster # state ${KSS}

=======================================================================================

# kubectl
### Test run an image on cluster
    kubectl create deployment test-kube # image  k8s.gcr.io/echoserver:1.4
    kubectl run test-kube # image k8s.gcr.io/echoserver:1.4 # port 8080  

### Expose or nat the container port randomly
    kubectl expose deployment test-kube # type=NodePort # port 8080
    kubectl expose pod test-kube # type=NodePort # port 8080
### Manual port forward optional
    kubectl port-forward <pod> 8080
    
### permanently save the namespace for all subsequent kubectl commands in that context.
    kubectl config set-context # current # namespace=ggckad-s2

### Shell to container
    kubectl exec -it shell-demo #  /bin/bash

### Node label
    use nodeSelector in deployment.yml

### Health check
    livenessProbes: check whether container is running, if not restart
    readiness: check if pod is ready to serve request, if not remove pod IP from service

### get log of running start up command in container
    kubectl logs -p [pod name]

=======================================================================================

# helm

### add helm repo
    helm repo add stable https://kubernetes-charts.storage.googleapis.com/

### Get helm charts
    helm ls # all

### Deploy helm chart

### Update helm chart
    helm upgrade hello-world ./hello-world

    helm rollback hello-world 1

    helm delete # purge hello-world

    helm package ./hello-world

### install nginx-ingress
    hell install nginx-ingress stable/nginx-ingress
=======================================================================================

# gcloud 

### login
    gcloud auth login

### set up project
    gcloud projects list
    gcloud config set project $GCP_PROJECT_ID
    gcloud config set compute/zone us-central1-a

### Generate kubectl credential for local 
    gcloud container clusters list
    gcloud container clusters get-credentials cluster-name

### Create Persistent compute disk
    gcloud compute disks create # type=pd-standard # size=1GB [name]

### create GKE cluster
    gcloud container clusters create cluster-1 # num-nodes 2 # machine-type g1-small

### Create docker image w gcloud
    gcloud config set compute/zone us-central1-f

    gcloud builds submit # tag us.gcr.io/$GCP_PROJECT_ID/snappass-nginx:$SNAPPASS_NGINX_GIT_SHA .

    gcloud container images list # repository us.gcr.io/$GCP_PROJECT_ID



# -docker

### build local docker image
    docker build # tag snappass:1.0 .

### run container for local built image
    docker run # publish 5000:5000 -e REDIS_HOST='192.168.1.75' snappass:1.0