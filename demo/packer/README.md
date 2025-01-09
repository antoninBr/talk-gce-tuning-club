# Packer

Pour l'installer c'est [là](https://developer.hashicorp.com/packer/install?product_intent=packer).

## Validation

```shell
packer validate tomcat-image.pkr.hcl
```
 
 ## Construction

```shell
packer build -var project_id=[PROJECT_ID] tomcat-image.pkr.hcl
```
