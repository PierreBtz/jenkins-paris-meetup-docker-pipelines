#!/usr/bin/env groovy

def toolImage = 'node:6.10.0'
def documentationImage = 'asciidoctor/docker-asciidoctor'
def dockerRegistry = 'https://index.docker.io/v1/'
def dockerCredentialsId = 'docker-hub'
def commitId

node {
  stage('prepare') {
    checkout scm
    commitId = getCommitId()

    docker.image(toolImage).inside {
      sh 'npm install'
    }
    stash 'workspace'
  }
}

stage('run') {
  parallel compilation: {
    node {
      unstash 'workspace'
      docker.image(toolImage).inside {
        sh 'npm run build'
      }
      stash includes: 'dist/**.*', name: 'dist'
      stash includes: 'run-e2e.sh, Dockerfile', name: 'scripts'
    }
  }, 'unit tests': {
    node {
      unstash 'workspace'
      docker.image(toolImage).inside {
        sh 'npm run test -- --code-coverage --single-run true'
      }
      stash includes: 'coverage/**.*', name: 'coverage'
    }
  }, 'documentation': {
    node {
      unstash 'workspace'
      docker.image(documentationImage).inside {
        sh 'asciidoctor -o output/index.html doc/application.adoc'
      }
      stash includes: 'output/**.*', name: 'documentation'
    }
  }
}

node {
  unstash 'dist'
  unstash 'coverage'
  unstash 'documentation'
  unstash 'scripts'

  def dockerImage

  stage('build image') {
    dockerImage = docker.build "pierrebtz/paris-meetup-pipeline-docker-app:${commitId}"
  }

  stage('e2e') {
    /* in our real case, we use protractor with a selenium grid,
    with parallel branches for the different browsers.
    To keep the demo autocontained, the protactor test is replaced by a
    simple curl call checking whether the container correctly serves a page or not.
    */
    dockerImage.withRun('-P') { c ->
      def containerUrl = c.port(80).replaceAll('0.0.0.0', getHostIp())
      sh "./run-e2e.sh ${containerUrl}"
    }
  }

  stage('publish') {
    parallel "docker image": {
      docker.withRegistry(dockerRegistry, dockerCredentialsId) {
        dockerImage.push()

        if ("${env.BRANCH_NAME}" == 'master') {
          dockerImage.push 'latest'
        }
      }
    }, 'code coverage': {
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'coverage', reportFiles: 'index.html', reportName: 'Coverage'])
    }, 'documentation': {
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: true, keepAll: true, reportDir: 'output', reportFiles: 'index.html', reportName: 'Documentation'])
    }
  }
}

def getCommitId() {
  sh returnStdout: true, script: 'echo -n $(git rev-parse --short HEAD)'
}

def getHostIp() {
  sh returnStdout: true, script: 'echo -n $(/sbin/ip route|awk \'/default/ { print $3 }\')'
}
