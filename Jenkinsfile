#!groovy​

node {
    stage('Tools check') {
        git 'https://github.com/PierreBtz/jenkins-meetup-demo.git'
        try {
            sh returnStatus: true, script: 'java -version'
        } catch (ignored) {
            echo 'No java executable found'
        }
        try {
            sh returnStatus: true, script: 'mvn'
        } catch (ignored) {
            echo 'No mvn executable found'
        }
    }
    stage('Build') {
        docker.image('maven:3.3.9-jdk-8').inside {
            sh '''java -version \
                && mvn -version \
                && mvn install'''
        }
    }
    stage('Results') {
        junit '**/target/surefire-reports/TEST-*.xml'
        archive 'target/*.jar'
    }
}