# Using Terraform and Ansible to deploy Jenkins, React JS app on AWS

## Installation
```
Terraform v0.12.13
Ansible 2.8.6
aws-cli 1.14.44 
Python 3.6.8 
Linux 4.15.0-65-generic
botocore 1.8.48
Docker version 18.09.7
```

## Usage

### Run by Docker (or ECS Fargate)

Running with Docker, all the information needed to access instance will be stored in S3 bucket, in the folder named by the `PROJECT_NAME`.

* Create S3 bucket
* Specify the following environment variables before running docker:
  * `AWS_ACCESS_KEY_ID`
  * `AWS_SECRET_ACCESS_KEY`
  * `AWS_DEFAULT_REGION`
  * `PROJECT_NAME`
  * `S3_BUCKET`
* Build docker image
* Run docker image with the above env var.

### Run in local

Running in local machine, all the information will be stored locally, in scripts folder.

* Log in as root user
* Export `PROJECT_NAME` variable to the terminal
* Create keypair with `ssh-keygen -t rsa -N "" -f /root/.ssh/$PROJECT_NAME`
* Configure AWS Credentials
* Run `TF_VAR_PROJECT_NAME=$PROJECT_NAME TF_VAR_public_key_path=/root/.ssh/$PROJECT_NAME.pub terraform apply -var-file=../var/terraform.tfvars -auto-approve`
