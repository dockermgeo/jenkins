

APP="jenkins"
NAMESPACE="dockermgeo"
IMAGE="$(NAMESPACE)/$(APP)"
VERSION="latest"
IDS=`docker ps | grep jenkinsfile-|awk '{print $$1}'`

install: build

build:
	docker build -t $(IMAGE):$(VERSION) .

compose.build:
	docker-compose pull
	docker-compose build

run:
	docker-compose up

stop:
	docker rm -f $(IDS)
