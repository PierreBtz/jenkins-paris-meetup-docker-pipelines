FROM jenkinsci/jenkins:2.46.1
MAINTAINER Pierre Beitz <pibeitz@gmail.com>

USER root

RUN curl -sSL https://get.docker.com/ | sh && \
    usermod -aG docker jenkins

RUN echo 2.31 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo 2.31 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

RUN /usr/local/bin/install-plugins.sh \
  docker-workflow:1.10 \
  blueocean:1.0.0 \
  docker-plugin:0.16.1 \
  credentials:2.1.13 \
  htmlpublisher:1.12

USER jenkins

COPY config.xml /usr/share/jenkins/ref/jobs/jenkins-meetup-demo/config.xml
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

EXPOSE 8080
