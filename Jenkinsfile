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
                    url: """${GCP_DEVOPS}"""
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
        /*stage('Install Dependencies') {
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
        }*/

        stage('Build Image') {
            steps {
                script {
                    sh """docker pull ${DOCKER_NAME}/${DOCKER_IMAGE}:latest || exit 0"""
                    sh """docker build -t ${DOCKER_NAME}/${DOCKER_IMAGE}:${env.BUILD_NUMBER} ."""
                    sh """docker push ${DOCKER_NAME}/${DOCKER_IMAGE}:${env.BUILD_NUMBER}"""
                }
            }
        }
        stage('Scan Image') {
            steps {
                sh """
                    trivy image --format template --template "${PATH}/html.tpl" -o test_result.html ${DOCKER_NAME}/${DOCKER_IMAGE}:${env.BUILD_NUMBER}
                """
            }
        }

        stage('Trigger Downstream Job') {
            steps {
                build(job: 'update-manifest-github', parameters: [
                    string(name: 'DOCKTERTAG', value: env.BUILD_NUMBER)
                ])
            }
        }
    }
}
