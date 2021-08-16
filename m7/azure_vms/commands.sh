# First we are going to initialize the Terraform config
terraform init

# Next we are going to plan our deployment
# Make sure to change the YOUR_CERTIFICATE_CN to the fqdn on
# your TLS certificate.
terraform plan -var leader_tls_servername=YOUR_CERTIFICATE_CN -out azurevm.tfplan

# Now we'll apply the plan to create the resources
terraform apply azurevm.tfplan

# Included in the output will be the public DNS name and IP address
# You can SSH into the first Vault server by using SSH and port 2022
# First we'll need to copy the SSH private key over to your home directory
# This should apply the proper permissions to the private key to make SSH happy
cp azure_vms_private_key.pem ~/.ssh/

# Now we'll connect to the first Vault server using SSH to initialize Vault
ssh azureuser@20.72.185.118 -p 2022 -i ~/.ssh/azure_vms_private_key.pem

# Once you're connected we'll initialize the Vault server and raft cluster
# 