#!/bin/bash
# -v $SONAR_VOLUME_DATA \
# SONAR_VOLUME_DATA="./../volumes/sonar-data:/opt/sonarqube/data"
# Configurações do SonarQube
SONAR_CONTAINER_NAME="sonar"
SONAR_IMAGE="sonarqube:9.9-community"  # Use a imagem do SonarQube que deseja usar
SONAR_DOCKERFILE="./../builds/Dockerfile.sonar"  # Caminho para o Dockerfile
SONAR_CONTEXT="./../builds/"  # Contexto do build
SONAR_VOLUME_LOGS="./../volumes/sonarqube/logs:/opt/sonarqube/logs"
SONAR_VOLUME_EXTENSIONS="./../volumes/sonarqube/extensions:/opt/sonarqube/extensions"
SONAR_PORT="9000:9000"
SONAR_ENV_VARS=(
  "SONAR_JDBC_URL=jdbc:postgresql://172.18.0.6:5432/sonar"
  "SONAR_JDBC_USERNAME=sonar"
  "SONAR_JDBC_PASSWORD=sonar"
)
SONAR_NETWORK="laboratoriojenkins_lab-snet-01"
SONAR_IP="172.18.0.5"

# Iniciar o container do SonarQube
docker run \
  --name $SONAR_CONTAINER_NAME \
  -p $SONAR_PORT \
  -v $SONAR_VOLUME_LOGS \
  -v $SONAR_VOLUME_EXTENSIONS \
  --network $SONAR_NETWORK \
  --ip $SONAR_IP \
  "${SONAR_ENV_VARS[@]/#/-e }" \
  -d \
  sonarqube:9.9-community
