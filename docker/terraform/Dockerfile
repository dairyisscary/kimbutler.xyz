FROM cimg/base:2022.04

RUN sudo apt-get update && sudo apt-get -y install jq

ENV TERRAFORM_VERSION=1.1.9
RUN sudo apt-get -y install curl unzip \
  && curl -SsL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform.zip \
  && sudo unzip terraform.zip -d /bin \
  && rm -rf terraform.zip \
  && sudo apt-get -y remove curl unzip
