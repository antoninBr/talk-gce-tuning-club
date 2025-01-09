# Packer

Pour l'installer c'est [là](https://developer.hashicorp.com/packer/install?product_intent=packer).

## Création compte de service

```shell
gcloud iam service-accounts create packer-builder --display-name "Packer Builder"
gcloud projects add-iam-policy-binding [PROJECT_ID] \
    --member "serviceAccount:packer-builder@[PROJECT_ID].iam.gserviceaccount.com" \
    --role "roles/compute.imageUser"
gcloud projects add-iam-policy-binding [PROJECT_ID] \
    --member "serviceAccount:packer-builder@[PROJECT_ID].iam.gserviceaccount.com" \
    --role "roles/compute.instanceAdmin.v1"
```
## Génération clé Json du SA

```shell
gcloud iam service-accounts keys create packer-key.json \
    --iam-account packer-builder@[PROJECT_ID].iam.gserviceaccount.com
```

## Validation

```shell
packer validate tomcat-image.pkr.hcl
```
 
 ## Construction

```shell
packer build -var project_id=[PROJECT_ID] tomcat-image.pkr.hcl
```
