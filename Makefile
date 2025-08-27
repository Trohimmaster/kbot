# Переменные
IMAGE_REGISTRY?=ghcr.io
IMAGE_REPO?=trohimmaster/kbot
VERSION?=1.0.1
GIT_SHA=$(shell git rev-parse --short HEAD)
IMAGE_TAG=v$(VERSION)-$(GIT_SHA)-linux-amd64
NAMESPACE?=kbot

# Объявляем цели как PHONY (не связанные с файлами)
.PHONY: test lint build push helm-lint helm-package helm-upgrade

# Тесты
test:
	go test ./...

# Сборка Docker образа
build:
	docker build -t $(IMAGE_REGISTRY)/$(IMAGE_REPO):$(IMAGE_TAG) .

# Пуш Docker образа
push:
	docker push $(IMAGE_REGISTRY)/$(IMAGE_REPO):$(IMAGE_TAG)

# Линт Helm чарта
helm-lint:
	helm lint .helm/kbot

# Пакетирование Helm чарта
helm-package:
	mkdir -p charts
	helm package ./helm -d charts

# Деплой / обновление Helm релиза
helm-upgrade:
	helm upgrade --install kbot ./charts/kbot-$(VERSION).tgz \
		--namespace=$(NAMESPACE) --create-namespace \
		--set image.registry=$(IMAGE_REGISTRY) \
		--set image.repository=$(IMAGE_REPO) \
		--set image.tag=$(IMAGE_TAG)
