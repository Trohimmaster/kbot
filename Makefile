IMAGE_REGISTRY=ghcr.io
IMAGE_REPO=trohimmaster/kbot
VERSION?=v1.0.1
GIT_SHA=$(shell git rev-parse --short HEAD)
IMAGE_TAG=$(VERSION)-$(GIT_SHA)-linux-amd64

test:
	echo "Running tests..."

build:
	docker build -t $(IMAGE_REGISTRY)/$(IMAGE_REPO):$(IMAGE_TAG) .

push:
	docker push $(IMAGE_REGISTRY)/$(IMAGE_REPO):$(IMAGE_TAG)

helm-package:
	helm package helm/kbot -d ./charts

helm-upgrade:
	helm upgrade --install kbot ./charts/kbot-$(VERSION).tgz \
		--namespace=kbot --create-namespace \
		--set image.tag=$(IMAGE_TAG)

