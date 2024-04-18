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

        /*stage('Code Analysis') {
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
        stage('Install Dependencies') {
            steps {
                sh "npm ci"
            }
        }
        stage('OWASP FS SCAN') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'DP-Check'
                dependencyCheckPublisher pattern: "/dependency-check-report.xml"
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh 'trivy fs . > $HOME/trivyfs.txt'
            }
        }*/

        stage('Build Image') {
            steps {
                script {
                    DOCKER_IMAGE="gitops-demo"
                    sh 'docker pull dckb9xz/$DOCKER_IMAGE || exit 0'
                    sh 'docker build -t dckb9xz/$DOCKER_IMAGE .'
                    sh 'docker push dckb9xz/$DOCKER_IMAGE'
                }
            }
        }
        /*stage('Scan Image') {
            steps {
                sh 'docker pull aquasec/trivy:0.18.3'
                sh 'docker run --rm -v $HOME/.cache/ aquasec/trivy:0.18.3 dckb9xz/todo:latest'
            }
        }*/

        stage('Trigger Downstream Job') {
            steps {
                build(job: 'update-manifest-github', parameters: [
                    string(name: 'DOCKTERTAG', value: 'latest')
                ])
            }
        }
    }
}
