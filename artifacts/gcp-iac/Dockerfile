##### SHOULD RARELY CHANGED BY ADMINS #####
# Build and push manually using:
# IMAGE_TAG=$(cat image-tag.txt) && docker build --build-arg IMAGE_TAG=$IMAGE_TAG --build-arg TERRAFORM_VERSION=latest -t us-central1-docker.pkg.dev/reditum-global-iac/iac/gcp-iac:$IMAGE_TAG .
# docker push us-central1-docker.pkg.dev/reditum-global-iac/iac/gcp-iac:$IMAGE_TAG
###########################################
ARG TAG=3.11.5-alpine3.18

FROM python:${TAG}

ARG GCLOUD_VERSION=${GCLOUD_VERSION:-450.0.0}
ARG IMAGE_TAG=${IMAGE_TAG:-latest}
ARG TERRAFORM_VERSION=${TERRAFORM_VERSION:-1.6.6}

LABEL maintainer="aguerrero@reditum.ec" \
      description="Allows run Terraform commands for creating GCP resources" \
      version=${IMAGE_TAG}

WORKDIR /config

RUN apk add --no-cache \
    bash=~5 \
    curl=~8 \
    git=~2 \
    openssh=~9 \
    unzip=~6 && \
    python3 -m pip install --no-cache-dir --upgrade pip

###################
# Install Terraform
###################
RUN if [ "${TERRAFORM_VERSION}" = "latest" ]; then \
        TERRAFORM_VERSION="$(curl -s https://api.github.com/repos/hashicorp/terraform/releases/latest | grep tag_name | grep -o -E -m 1 "[0-9.]+")" \
    ; fi && \
    curl -L "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" > terraform.zip && \
    unzip terraform.zip -d /usr/local/bin && rm terraform.zip

####################
# Install gcloud CLI
####################
RUN curl -L "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz" > gcloud.tar.gz && \
    tar -xf gcloud.tar.gz && ./google-cloud-sdk/install.sh --quiet && rm gcloud.tar.gz && ln -s /config/google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud

ENTRYPOINT [ "/bin/bash" ]
