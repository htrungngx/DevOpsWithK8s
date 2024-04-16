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

        stage('Code Analysis') {
            environment {
                scannerHome = tool 'sonar-scanner'
            }
            steps {
                withSonarQubeEnv('sonar-scanner') {
                    sh """
                        ${scannerHome}/bin/sonar-scanner \
                        -Dsonar.projectName=Todo-testing \
                        -Dsonar.projectKey=Todo-testing \
                        -Dsonar.sources=. \
                        -Dsonar.scm.disabled=True
                    """
                }
            }
        }
        stage("Quality gate"){
           steps {
                script {
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonarID' 
                }
            } 
        }
        stage('Build Image') {
            steps {
                script {
                    sh 'docker pull dckb9xz/todo:latest || exit 0'
                    sh 'docker build -t dckb9xz/todo .'
                    sh 'docker push dckb9xz/todo'
                }
            }
        }
        stage('Scan Image') {
            steps {
                script {
                    sh 'trivy image dckb9xz/todo:latest > $HOME/trivy.txt'
                }
            }
        }
    }
}
