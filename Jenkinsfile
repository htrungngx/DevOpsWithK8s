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
        stage('Install Dependencies') {
            steps {
                sh 'npm install .'
            }
        }
        stage ('OWASP Dependency-Check Vulnerabilities') {
            steps {
                dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit', odcInstallation: 'dp-check'
                dependencyCheckPublisher pattern: 'dependency-check-report.xml'
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh 'trivy fs . > $HOME/trivyfs.txt'
            }
        }

        stage('Build Image') {
            steps {
                script {
                    sh 'docker pull dckb9xz/todo || exit 0'
                    sh 'docker build -t dckb9xz/todo .'
                    sh 'docker push dckb9xz/todo'
                }
            }
        }
        stage('Scan Image') {
            steps {
                sh 'trivy image dckb9xz/todo > $HOME/trivyimage.txt'
            }
        }

        stage('Trigger Downstream Job') {
            steps {
                build(job: 'update-manifest-github', parameters: [
                    string(name: 'DOCKTERTAG', value: 'latest')
                ])
            }
        }
    }
}
