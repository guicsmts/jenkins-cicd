#!/bin/bash

# Script de setup para construir e executar o ambiente Docker sem docker-compose

# Definir o prefixo do projeto para as tags das imagens
PROJECT_PREFIX="laboratoriojenkins"

# Diretório onde estão os Dockerfiles
DOCKERFILES_DIR="./builds/dockerfiles"

# Nome da rede Docker
NETWORK_NAME="laboratoriojenkins_lab-snet-01"

# Sub-rede da rede Docker
SUBNET="172.18.0.0/16"

# Função para construir as imagens Docker
build_images() {
    echo "Iniciando a construção das imagens Docker..."

    # Iterar sobre cada Dockerfile no diretório especificado
    for dockerfile in "$DOCKERFILES_DIR"/Dockerfile.*; do
        # Extrair o sufixo do nome do Dockerfile (ex: Dockerfile.mysql -> mysql)
        service_name=$(basename "$dockerfile" | cut -d. -f2)

        # Definir a tag da imagem no formato laboratoriojenkins-<serviço>
        image_tag="${PROJECT_PREFIX}-${service_name}"

        echo "Construindo a imagem para o serviço: $service_name com a tag: $image_tag"

        # Construir a imagem Docker
        docker build -f "$dockerfile" -t "$image_tag" "$DOCKERFILES_DIR"

        # Verificar se a construção foi bem-sucedida
        if [ $? -ne 0 ]; then
            echo "Erro ao construir a imagem para o serviço: $service_name"
            exit 1
        fi
    done

    echo "Construção das imagens concluída com sucesso."
}

# Função para criar a rede Docker se não existir
create_network() {
    echo "Verificando a existência da rede Docker '$NETWORK_NAME'..."

    # Verificar se a rede já existe
    if ! docker network ls --format '{{.Name}}' | grep -w "$NETWORK_NAME" > /dev/null; then
        echo "Criando a rede Docker '$NETWORK_NAME' com a sub-rede '$SUBNET'..."
        docker network create "$NETWORK_NAME" --driver bridge --subnet "$SUBNET"

        # Verificar se a criação da rede foi bem-sucedida
        if [ $? -ne 0 ]; then
            echo "Erro ao criar a rede Docker '$NETWORK_NAME'."
            exit 1
        fi
    else
        echo "A rede Docker '$NETWORK_NAME' já existe."
    fi
}

# Função para executar os containers
run_containers() {
    echo "Iniciando os containers..."

    # Definir as configurações para cada serviço
    declare -A services

    # Formato: serviços[<nome_do_serviço>]="<portas>;<variáveis_ambiente>;<volumes>;<ip>"

    services=(
        ["php-fpm"]="9001:9000;;172.18.0.8"
        ["nginx"]="80:80,443:443;;172.18.0.2"
        ["mysql"]="3306:3306;MYSQL_ROOT_PASSWORD=6bbf8192cfe6e7558b443888,MYSQL_DATABASE=lemp/laravel,MYSQL_USER=lempdb2cfe6e,MYSQL_PASSWORD=lab-secret-me;./volumes/db-lemp:/var/lib/mysql;172.18.0.13"
        ["jenkins"]="8070:8080;;172.18.0.4"
        ["postgresql"]="5432:5432;POSTGRES_DB=sonar,POSTGRES_USER=sonar,POSTGRES_PASSWORD=sonar,POSTGRES_ROOT_PASSWORD=Snar2024;./volumes/db-sonar:/var/lib/postgresql/data;172.18.0.6"
        ["agent"]="8000:80,3222:22;;172.18.0.60"
        ["trivy"]="8090:8090,22:22;;172.18.0.70"
        ["owaspzap"]="8080:8080;;172.18.0.80"
    )

    # Iterar sobre cada serviço e executar o container correspondente
    for service in "${!services[@]}"; do
        # Extrair as configurações do serviço
        IFS=';' read -r ports env_vars volumes ip <<< "${services[$service]}"

        # Definir a tag da imagem
        image_tag="${PROJECT_PREFIX}-${service}"

        # Definir o nome do container
        container_name="$service"

        echo "Iniciando o container '$container_name' a partir da imagem '$image_tag'..."

        # Compor os argumentos para o comando docker run
        docker_run_args=(
            "--name" "$container_name"
            "--network" "$NETWORK_NAME"
            "--ip" "$ip"
            "-d" # Executar em modo detached
        )

        # Adicionar mapeamento de portas se existir
        if [ -n "$ports" ]; then
            IFS=',' read -ra port_mappings <<< "$ports"
            for port in "${port_mappings[@]}"; do
                docker_run_args+=("-p" "$port")
            done
        fi

        # Adicionar variáveis de ambiente se existirem
        if [ -n "$env_vars" ]; then
            IFS=',' read -ra env_list <<< "$env_vars"
            for env in "${env_list[@]}"; do
                docker_run_args+=("-e" "$env")
            done
        fi

        # Adicionar volumes se existirem
        if [ -n "$volumes" ]; then
            IFS=',' read -ra volume_list <<< "$volumes"
            for volume in "${volume_list[@]}"; do
                docker_run_args+=("-v" "$volume")
            done
        fi

        # Dependências (não implementadas aqui, mas podem ser gerenciadas com delays ou checagens)

        # Especificar a imagem a ser usada
        docker_run_args+=("$image_tag")

        # Executar o container
        docker run "${docker_run_args[@]}"

        # Verificar se a execução foi bem-sucedida
        if [ $? -ne 0 ]; then
            echo "Erro ao iniciar o container '$container_name'."
            exit 1
        fi
    done

    echo "Todos os containers foram iniciados com sucesso."
}

# Função principal para executar as etapas de setup
main() {
    build_images
    create_network
    run_containers
    echo "Setup do ambiente concluído."
}

# Executar a função principal
main
