pipeline {
    agent any
    tools {
        jdk 'jdk20'
    }

    stages {
        //Clone code from repogistory
        stage('Clone') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/htrungngx/GCP-Devops.git'
            }
        }

        //Build code with Docker and Push to Registry
        stage('Build Image') {
            steps {
                {
                    sh 'docker pull dckb9xz/todo:latest || exit 0'
                    sh 'docker build -t dckb9xz/todo .'
                    sh 'docker push dckb9xz/todo'
                }
            }
        }
        /*//Deploy to Dev Environment
        stage('Deploy to DevEnv') {
            steps {
                echo 'Deploying and Cleaning'
                sh 'docker pull dckb9xz/app:latest'
                sh 'docker ps -a'
                sh "docker rm -f movieapp || echo 'The container does not exist'" //Remove exist container
                sh 'docker run --name movieapp -p 3000:3000 -d dckb9xz/app'
            }
        }
    //Deploy to production server
    }*/
}
}

