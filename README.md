# wp1
Run Terraform
1. Install the latest terraform
2. In you bash shell export TF_VAR_az_sub_id="<azure subscription id>"
3. Go to terraform directory
4. Run <terraform init>
5. Run <terraform plan> and review the potential changes
6. If you agree with the plan, then run <terraform apply>

Ansible
1. Install ansible 2.15 or newer
2. Install the azure.azcollection collection (version 2.7.0).   (https://galaxy.ansible.com/ui/repo/published/azure/azcollection/)
3. Go to ansible directory
4. Add the azure information in the vars.yaml under secret section
5. Run <ansible-playbook wp1-playbook.yaml>