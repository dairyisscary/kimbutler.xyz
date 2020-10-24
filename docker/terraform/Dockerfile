FROM dairyisscary/circleci:3.0.0-kimbutlerxyz

RUN apt-get update && apt-get -y install jq

ENV TERRAFORM_VERSION=0.13.5
RUN apt-get -y install curl unzip \
  && curl -SsL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform.zip \
  && unzip terraform.zip -d /bin \
  && rm -rf terraform.zip \
  && apt-get -y remove curl unzip
