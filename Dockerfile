FROM python:3.6-alpine

RUN apk add --no-cache curl unzip ansible openssh
RUN pip install awscli

WORKDIR /terraform
RUN curl -O https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip && \
  mkdir /bin/terraform && \
  unzip terraform_0.12.13_linux_amd64.zip -d /bin/terraform && \
  rm terraform_0.12.13_linux_amd64.zip

ENV PATH $PATH:/bin/terraform

WORKDIR /app
COPY . .

CMD [ "./run.sh" ]