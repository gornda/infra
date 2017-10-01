# infra

Educational repository. Provide several ways to prepare infrastructure (Ruby, MongoDB and Puma) and deploy sample app.

Preconditions:
* valid google cloud platform account and active project.

1. Packer & bash scprits to prepare image for instance:
  Usage: ```packer build -var-file vars.json ubuntu16.json``` - will "bake" image for instance with Ruby and MongoDB installed.
  In vars.json you should use your project name on GCP, something like "infra-999999".
2. Packer & Ansible to prepare instances for db and for app separately.
  Usage:
  ```packer build -var-file vars.json app.json``` &
  ```packer build -var-file vars.json db.json```

2. Terraform to deploy instances and set firewall rules. There are two environments - stage and prod. Differense is in firewall settings (ssh access to stage is available from any IP address, ssh access is available only from specific IP).
Usage:
    1. ```cd ~/infra/terraform/stage``` or ```cd ~/infra/terraform/prod```
    2. Add file terraform.vars with correct settings (there is terraform.vars.example file in /terraform folder)
    2. ```terraform plan``` (to check planned changes).
    3. ```terraform apply```

3. Ansible to deploy instances, configure software and deploy application.
Usage:
   1. ```cd ~/infra/ansible```
   2. packer_reddit_app.yml will prepare instance with installed Ruby
   3. packer_reddit_app.yml will prepare instance with installed MongoDB
   4. reddit_app.yml will configure both instances, clone and deploy sample application. First use "db-tag", then "app-tag" and finaly "deploy tag":
   Example: ```ansible-playbook reddit-app.yml --tag app-tag```
