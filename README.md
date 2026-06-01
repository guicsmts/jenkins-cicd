# Projeto LEMP com Docker 🐳

Este repositório contém a configuração para um ambiente LEMP usando Docker, facilitando a execução de uma pilha de desenvolvimento Linux, NGINX, MySQL e PHP em contêineres.

## Requisitos 📋

Para executar este projeto, você precisará ter o Docker e o Docker Compose instalados em sua máquina.

## Configuração do Ambiente 🛠️

O ambiente LEMP é composto por:

- **MySQL 5.7:** Banco de dados relacional.
- **PHP 7.2-FPM:** Versão FastCGI do PHP.
- **NGINX (latest):** Servidor web leve e de alto desempenho.

## Inicialização do Projeto 🚀

Para iniciar o ambiente LEMP, siga estas etapas:

1. **Clone o Repositório:**

```bash
   git clone <url_do_repositorio>
   cd <nome_do_repositorio>
```

2. **Construa e Inicie os Serviços:**

Execute o comando abaixo para construir e iniciar os serviços em contêineres Docker:

```bash
   docker-compose up --build

```

Este comando fará o Docker Compose construir as imagens necessárias e iniciar os contêineres.

# Acessando os Serviços 🌐

Web Server: O NGINX estará acessível na porta 80. Você pode acessar seu aplicativo PHP navegando para http://localhost em seu navegador.

Banco de Dados: O MySQL estará rodando na porta padrão (3306). Você pode acessá-lo usando suas ferramentas de gerenciamento de banco de dados preferidas.

# Estrutura de Arquivos 📂
Descreva aqui como o projeto está estruturado, incluindo onde os arquivos de configuração do Docker e os arquivos de aplicativos PHP estão localizados.

# Contribuições e Suporte 🤝
Instruções sobre como contribuir para o projeto, reportar bugs e solicitar funcionalidades.

