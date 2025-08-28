# My Telegram Bot

Бот написаний на Go з використанням Cobra CLI та Telebot API.

## Запуск

```bash
export TELE_TOKEN=ваш_токен
go run main.go

## Лінк на бота 
https://t.me/kbot_kbot_bot


### CI/CD Flow

```mermaid
flowchart LR
  A[Push to develop] --> B[GitHub Actions]
  B --> C[Build Docker image]
  C --> D[Push to ghcr.io]
  D --> E[Update helm/values.yaml]
  E --> F[Commit & Push to develop]
  F --> G[Argo CD watches repo]
  G --> H[Sync Helm chart to cluster]
  H --> I[Bot running in Kubernetes]
