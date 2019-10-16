#
APP := "jenkins"
NAMESPACE := "dockermgeo"
IMAGE := "$(NAMESPACE)/$(APP)"
VERSION := "latest"
IDS := $(shell docker ps | grep jenkinsfile-|awk '{print $$1}')
HOSTNAME := $(shell hostname)
install: build
#

## BUILD
prebuild: build.rename
	sudo mkdir -p /docker/data/JENKINS
	sudo mkdir -p /docker/data/GITLAB

build.rename:
	cat docker-compose.tpl | sed -e 's#githost#$(HOSTNAME)#' >docker-compose.yml;

build.plain: prebuild
	docker build -t $(IMAGE):$(VERSION) .

build: prebuild
	docker-compose -f docker-jenkins.yml build


## RUN
run: build.rename
	docker-compose -f docker-jenkins.yml up

stop:
	docker rm -f $(IDS)
