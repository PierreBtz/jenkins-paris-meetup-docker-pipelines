FROM jenkinsci/jenkins:2.32.3
MAINTAINER Pierre Beitz <PierreBtz@users.noreply.github.com>

USER root

RUN curl -sSL https://get.docker.com/ | sh

RUN usermod -aG docker jenkins

RUN echo 2.31 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state && \
    echo 2.31 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

RUN /usr/local/bin/install-plugins.sh docker-workflow:1.10 blueocean:1.0.0-rc1

USER jenkins
COPY config.xml /usr/share/jenkins/ref/jobs/jenkins-meetup-demo/config.xml

EXPOSE 8080