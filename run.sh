#!/bin/sh
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
aws configure set default.region $AWS_DEFAULT_REGION
mkdir /etc/ansible/ && printf "[defaults]\nhost_key_checking = False\n[ssh_connection]\nretries=10" > /etc/ansible/ansible.cfg
ssh-keygen -t rsa -N "" -f /root/.ssh/$PROJECT_NAME
cd /app/infra
terraform init
TF_VAR_PROJECT_NAME=$PROJECT_NAME TF_VAR_public_key_path=/root/.ssh/$PROJECT_NAME.pub terraform apply -var-file=../var/terraform.tfvars -auto-approve
mkdir /$PROJECT_NAME/
cp terraform.tfstate /$PROJECT_NAME/
cp ../scripts/jenkinsInitPass.txt /$PROJECT_NAME/
cp /root/.ssh/$PROJECT_NAME* /$PROJECT_NAME/
cp ../scripts/aws* /$PROJECT_NAME/
cd /$PROJECT_NAME
aws s3 sync . s3://$S3_BUCKET/$PROJECT_NAME