
# Terraform Infra As Code

### Roadmap : Terraform + K8S on GCP

- [x] Créer un projet GCP et récupérer son identifiant
- [x] Tester le dashboard et la création de resources en ligne
- [x] Créer un compte de services pour automatisation Terraform
- [x] Télécharger fichier secret compte service (.gitignored !)
- [x] Activer les [APIs](#enable-apis)) GPC nécessaires au projet
- [x] Prise en main tarraform: providers, resources, modules
- [x] Création arborescance projet terraform `./infra/GCP`
- [ ] TF : Création de l'infra de base pour 1 env de test 
    - [x] K8S : Kong ingress controller 
    - [ ] K8S : Cert manager (SSL certificates)
    - [ ] K8S : External DNS (Manage domain from K8S within GCP)
- [ ] Mise en place des Microservices 
    - [ ] Création des services applicatifs
    - [ ] Tester génération certificats TLS
    - [ ] OAuth proxy autheticate api request
    - [ ] Communication gRPC entre services
    - [ ] Monitoring applicatif avec [Fluentd](https://www.fluentd.org)
- [ ] GitOPs : Pipeline intégration continuer Github actions
- [ ] GitOps : Livraison continue (images) avec Cloud Build
- [ ] GitOps : Pipeline Argo CD livaison continue
- [ ] TF : Secret encryption management
- [ ] TF : Multi env managment (dev, staging, prod) 
- [ ] Setup monitoring stack Prometheus + Grafana
- [ ] Setup log aggregation stack ELK


### How to 

Creation infrastructure

```bash
cd infra/GCP
terraform init
terraform plan
terraform apply
```


### TO FIX : 

- [ ] Bind the ExternalDNS GSA to the DNS admin role : https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/nginx-ingress.md#gke-with-workload-identity
- [ ] Node numbers (no corresponding to config)
- [ ] Choose DNS name_server (is it possible ?)


### [Activer les APIs](#enable-apis)

Aller dans la [bibliothèque d'API](https://console.cloud.google.com/apis/library) et activer :

1. Google Cloud DNS API
2. Compute Engine API - compute.googleapis.com
3. Kubernetes Engine API - container.googleapis.com

### GCP/GKE ServiceAccount permissions

|Identifian du rôle                         | Libellé                                       |
|-------------------------------------------|-----------------------------------------------|
| `roles/compute.networkAdmin`              | Administrateur de réseaux de Compute          |
| `roles/compute.securityAdmin`             | Administrateur de sécurité de Compute         |
| `roles/compute.viewer`                    | Lecteur de Compute                            |
| `roles/container.clusterAdmin`            | Administrateur de cluster Kubernetes Engine   |
| `roles/container.developer`               | Développeur sur Kubernetes Engine             |
| `roles/iam.serviceAccountAdmin`           | Administrateur de compte de service           |
| `roles/iam.serviceAccountUser`            | Utilisateur du compte de service              |
| `roles/resourcemanager.projectIamAdmin`   | Administrateur de projet IAM                  |
| `roles/dns.admin`                         | Administrateur DNS                            |


### GCP Commands

#### View access

```sh
gcloud projects get-iam-policy devops-training-303722 \
--flatten="bindings[].members" \
--format='table(bindings.role)' \
--filter="bindings.members:terraform-gke-1@devops-training-303722.iam.gserviceaccount.com"
```

#### Bind IAM role to SA on project

```sh
gcloud projects add-iam-policy-binding mikangali \
    --member=serviceAccount:terraform-gke-1@mikangali.iam.gserviceaccount.com --role=roles/dns.admin
```

#### DNS records

```sh
gcloud beta dns --project=devops-training-303722 record-sets transaction start --zone=kuguru-ga
gcloud beta dns --project=devops-training-303722 record-sets transaction add 192.16.0.1 --name=dev.kuguru.ga. --ttl=300 --type=A --zone=kuguru-ga
gcloud beta dns --project=devops-training-303722 record-sets transaction remove 104.198.219.72 --name=dev.kuguru.ga. --ttl=300 --type=A --zone=kuguru-ga
gcloud beta dns --project=devops-training-303722 record-sets transaction execute --zone=kuguru-ga
```

### Others

* Restore service account `gcloud beta iam service-accounts undelete UNIQ_ID`


### kubectl

```sh
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'alias k="kubectl"' >> .bashrc
echo 'complete -F __start_kubectl k' >>~/.bashrc

echo 'alias kx="kubectl explain"' >>~/.bashrc
echo 'alias kgp="kubectl get pods"' >>~/.bashrc
echo 'alias kdp="kubectl delete pod"' >>~/.bashrc
echo 'alias kgs="kubectl get svc"' >>~/.bashrc
echo 'alias kn="kubectl config set-context --current --namespace "' >>~/.bashrc
```


### Liens utiles

- https://github.com/hashicorp/learn-terraform-provision-gke-cluster
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started
- https://docs.microsoft.com/fr-fr/azure/developer/terraform/create-k8s-cluster-with-tf-and-aks
