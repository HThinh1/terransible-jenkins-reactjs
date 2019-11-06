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

* Create s3 bucket 
* Specify the following environment variables before running docker:
  * `AWS_ACCESS_KEY_ID`
  * `AWS_SECRET_ACCESS_KEY`
  * `AWS_DEFAULT_REGION`
  * `PROJECT_NAME`
  * `S3_BUCKET`
* Build docker image
* Run docker image with the above env var.

### Run in local