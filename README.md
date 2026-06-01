# Jenkins CI/CD

Ambiente completo para integração contínua (CI) e entrega contínua (CD) utilizando Jenkins, Docker e automação de pipelines para aplicações web.

## Visão Geral

Este projeto disponibiliza uma plataforma Jenkins containerizada para automação de processos de desenvolvimento, testes, análise de qualidade e deploy. O objetivo é centralizar a execução de pipelines CI/CD, reduzindo atividades manuais e aumentando a confiabilidade das entregas.

A estrutura foi organizada para permitir a configuração rápida de ambientes Jenkins, gerenciamento de jobs e integração com ferramentas de desenvolvimento modernas.

## Recursos

* Jenkins executando em containers Docker
* Pipelines as Code utilizando Jenkinsfile
* Integração com GitHub
* Integração com SonarQube
* Ambientes isolados para builds
* Configuração simplificada através do Docker Compose
* Estrutura organizada para múltiplos projetos
* Automação de processos de build e deploy

## Arquitetura

O ambiente é composto pelos seguintes componentes:

* Jenkins Server
* Docker Compose
* Jenkins Pipelines
* SonarQube Integration
* Build Workspaces
* Sites Configuration

## Estrutura do Projeto

```text
.
├── builds/
├── setup/
├── sites/
├── docker-compose.yml
├── Jenkinsfile.lab
├── sonar-project.properties
├── README.md
└── .gitignore
```

## Requisitos

* Docker
* Docker Compose
* Git
* Conta GitHub (opcional)
* SonarQube (opcional)

## Clone Repository

```bash
git clone https://github.com/<username>/jenkins-cicd.git

cd jenkins-cicd
```

## Start Environment

```bash
docker-compose up -d
```

## Check Running Containers

```bash
docker ps
```

## View Container Logs

```bash
docker logs -f jenkins
```

## Access Jenkins

```text
http://localhost:8080
```

## Retrieve Initial Admin Password

```bash
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

## Install Recommended Plugins

After the first login:

```text
Manage Jenkins
→ Plugins
→ Install Suggested Plugins
```

## Configure GitHub Integration

```text
Manage Jenkins
→ Credentials
→ Add Credentials
```

Configure:

* GitHub Token
* SSH Key (optional)
* Repository Access

## Configure SonarQube

```text
Manage Jenkins
→ System
→ SonarQube Servers
```

Add:

* Server URL
* Authentication Token

## Create Pipeline Job

```text
Dashboard
→ New Item
→ Pipeline
→ Pipeline Script from SCM
```

Configure:

```text
SCM: Git
Repository URL: <repository-url>
Script Path: Jenkinsfile
```

## Run Pipeline

```bash
Build Now
```

## Example Pipeline Stages

```text
1. Checkout Source Code
2. Dependency Installation
3. Unit Tests
4. Code Quality Analysis
5. Build Application
6. Publish Artifacts
7. Deploy Environment
```

## Use Cases

* Continuous Integration
* Continuous Delivery
* Continuous Deployment
* Automated Testing
* Static Code Analysis
* Multi-Environment Deployments
* DevOps Laboratories
* Development Team Automation

## Best Practices

* Store secrets using Jenkins Credentials
* Version control all Jenkinsfiles
* Separate build and deployment stages
* Automate quality gates with SonarQube
* Use isolated Docker agents whenever possible
* Implement approval stages for production deployments

## Contribuição

Contribuições, correções e melhorias são bem-vindas.

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Open a Pull Request

## Licença

Este projeto está disponível sob a licença definida pelo mantenedor do repositório.
