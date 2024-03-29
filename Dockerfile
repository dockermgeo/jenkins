FROM docker.io/jenkins/jenkins:latest

USER root

RUN apt-get update -y && \
    apt-get install -y awscli jq gettext-base tree vim zip

RUN wget https://download.docker.com/linux/static/stable/x86_64/docker-18.06.1-ce.tgz && \
	tar xzvf docker-18.06.1-ce.tgz && \
	cp docker/* /usr/bin/
RUN curl -L "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose && \
      chmod +x /usr/local/bin/docker-compose

COPY src/jenkins-share/plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt && \
    mkdir -p /share/jenkins-lib && chmod -R 777 /share

COPY docker_root/var/jenkins_home/ $JENKINS_HOME/
ADD src/jenkins_home /var/jenkins_home/
