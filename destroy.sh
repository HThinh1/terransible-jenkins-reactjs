cd infra
TF_VAR_PROJECT_NAME=$PROJECT_NAME TF_VAR_public_key_path=/root/.ssh/$PROJECT_NAME.pub terraform destroy -var-file=../var/terraform.tfvars -auto-approve -input=false
cd ../scm/github
TF_VAR_PROJECT_NAME=$PROJECT_NAME terraform destroy -auto-approve -input=false