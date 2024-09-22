# wp1
How to run from a linux bash shell

Run Terraform
1. Install the latest terraform
2. export TF_VAR_az_sub_id="your azure subscription id"
3. Go to terraform directory
4. terraform init
5. terraform plan 
6. terraform apply

Ansible
1. Install ansible 2.15 or newer
2. Install the azure.azcollection collection (version 2.7.0).   (https://galaxy.ansible.com/ui/repo/published/azure/azcollection/)
3. Go to ansible directory
4. Add the azure information in the vars.yaml under secret section
5. Run ansible-playbook wp1-playbook.yaml