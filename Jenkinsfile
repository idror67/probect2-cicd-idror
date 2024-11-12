pipeline {
    agent any

    stages {
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
        stage('check out git') {
            steps {
               git branch: 'main', url: 'https://github.com/idror67/probect2-cicd-idror.git'
            }
            
        }
        stage('build docker image') {
            steps {
                sh 'docker build -t cicd-flask-project2 .'
            }
            
        }
        stage('push to docker hub') {
              environment {
                  DOCKER = credentials('dockerhub')
              }
            steps {
                 sh 'docker login -u ${DOCKER_USR} -p ${DOCKER_PSW}'
                 sh 'docker tag cicd-flask-project2 idror/cicd-flask-project2:latest'
                 sh 'docker push idror/cicd-flask-project2:latest'
                
            }
        }
        stage('docker compose') {
            steps {
              sh 'docker-compose down'    
              sh 'docker-compose up'
            }
            
        }
    }
}