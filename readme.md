# infra

Educational repository. It provides several ways to prepare infrastructure (Ruby, MongoDB and Puma) and deploy sample app.

Preconditions:
* valid google cloud platform account and active project.

1. Packer & bash scprits will prepare image for single instance:
  Usage: ```packer build -var-file vars.json ubuntu16.json``` - will "bake" image for instance with Ruby and MongoDB installed.
  In vars.json you should use your project name on GCP, something like "infra-999999".
2. Packer & Ansible will prepare instances for db and for app separately.
  Usage:
  ```packer build -var-file vars.json app.json``` &
  ```packer build -var-file vars.json db.json```

2. Terraform will prepare instances and set firewall rules. There are two environments - stage and prod. Difference is in firewall settings (ssh access to stage is available from any IP address, ssh access is available only from specific IP).
Usage:
    1. ```cd ~/infra/terraform/stage``` or ```cd ~/infra/terraform/prod```
    2. Add file terraform.vars with correct settings (there is terraform.vars.example file in /terraform folder)
    2. ```terraform plan``` (to check planned changes).
    3. ```terraform apply```

3. Ansible will configure software on DB and APP instances and deploy sample application.
Usage:
   1. Prepare instances with Terraform
   2. Add App external IP and DB external IP to hosts file (infra/ansible/environments/prod/hosts or infra/ansible/environments/stage/hosts)
   3. Add DB internal IP to vars file for "app" group (infra/ansible/environments/prod/group_vars/app or infra/ansible/environments/stage/group_vars/app)
   4. ```cd ~/infra/ansible```
   5. Use ```ansible-playbook -i environments/<environment>/hosts site.yml --check``` to check future changes. By default stage environment will be selected.
   6. Use ```ansible-playbook -i environments/<environment>/hosts site.yml``` to configure instances and deploy sample application.
   7. Type <APP external IP>:9292 in your browser. Sample application will appear.
