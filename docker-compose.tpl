version: '3.5'

services:
  jenkins:
    image: dockermgeo/jenkins:latest
    build: .
    ports:
    - target: 8080
      published: 8080
    volumes:
    - type: bind
      source: '/var/run/docker.sock'
      target: '/var/run/docker.sock'
      read_only: true
    - type: bind
      source: '/data/docker/JENKINS'
      target: '/var/share/JENKINS'
      read_only: false
    tty: true

  git:
    image: 'gitlab/gitlab-ce:latest'
    restart: always
    hostname: 'githost'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://githost'
        # Add any other gitlab.rb configuration here, each on its own line
        prometheus_monitoring['enable'] = false
    ports:
      - '80:80'
      - '443:443'
      - '22:22'
    volumes:
      - '/docker/data/GITLAB/config:/etc/gitlab'
      - '/docker/data/GITLAB/logs:/var/log/gitlab'
      - '/docker/data/GITLAB/data:/var/opt/gitlab'




