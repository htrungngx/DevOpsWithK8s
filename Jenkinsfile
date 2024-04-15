pipeline {
    agent any
    tools {
        jdk 'jdk20'
        nodejs 'nodejs'
    }

    stages {
        stage('Clone') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/htrungngx/GCP-Devops.git'
            }
        }

        stage('Build Image') {
            steps {
                script {
                    docker.withRegistry('https://your.registry.url', 'credentials-id') {
                        sh 'docker pull dckb9xz/todo:latest || exit 0'
                        sh 'docker build -t dckb9xz/todo .'
                        sh 'docker push dckb9xz/todo'
                    }
                }
            }
        }
    }
}
