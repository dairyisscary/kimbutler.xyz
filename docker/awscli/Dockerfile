FROM cimg/base:2022.04

RUN sudo apt-get update && sudo apt-get -y install jq curl

ENV AWSCLI_VERSION=2.6.1
RUN sudo apt-get -y install unzip \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWSCLI_VERSION}.zip" -o awscliv2.zip \
  && unzip awscliv2.zip \
  && sudo ./aws/install \
  && rm awscliv2.zip \
  && sudo apt-get -y remove unzip
