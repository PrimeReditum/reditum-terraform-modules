##### SHOULD RARELY CHANGED BY ADMINS #####
# Build and push manually using:
# IMAGE_TAG=$(cat image-tag.txt) && docker build --build-arg IMAGE_TAG=$IMAGE_TAG -t us-central1-docker.pkg.dev/reditum-global-iac/iac/code-quality:$IMAGE_TAG .
# docker push us-central1-docker.pkg.dev/reditum-global-iac/iac/code-quality:$IMAGE_TAG
###########################################

ARG TAG=3.11.5-alpine3.18

FROM python:${TAG}

ARG IMAGE_TAG=${IMAGE_TAG:-latest}

LABEL maintainer="aguerrero@reditum.ec" \
      description="Allows run pre-commit tests for code quality agains the source code" \
      version=${IMAGE_TAG}

WORKDIR /config

###################
# Install Go
###################
COPY --from=golang:1.21.0-alpine3.18 /usr/local/go/ /usr/local/go/
ENV PATH=$PATH:/usr/local/go/bin

COPY requirements.txt .

RUN apk add --no-cache \
    zip \
    git=~2 \
    curl=~8 \
    bash=~5 \
    gcc=~12 \
    musl-dev=~1 \
    unzip=~6 && \
    python3 -m pip install --no-cache-dir --upgrade pip

###################
# Install Pip Tools
###################
RUN pip3 install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "/bin/bash" ]
