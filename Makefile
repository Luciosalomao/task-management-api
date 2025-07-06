# Nome da imagem e do container
IMAGE_NAME=task-management-api
CONTAINER_NAME=task-api

# Comando para buildar a imagem
build:
	docker build -t $(IMAGE_NAME) .

# Comando para remover container antigo
clean:
	docker rm -f $(CONTAINER_NAME) || true
	docker rmi -f $(IMAGE_NAME) || true

# Comando para rodar o container
run: build
	docker run --name $(CONTAINER_NAME) -p 3000:3000 --env-file .env $(IMAGE_NAME)

# Atalho completo: clean + build + run
restart: clean run
