pipeline {
    agent any

    environment {
        EC2_HOST = '3.75.203.135'
        EC2_USER = 'ubuntu'
        APP_DIR = '/home/ubuntu/DevOps-Message'
        REPO_URL = 'https://github.com/PKanta0/DevOps-Message.git'
        BRANCH = 'main'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test Backend') {
            steps {
                dir('backend') {
                    sh 'npm install'
                    sh 'npm test'
                }
            }
        }

        stage('Build Docker Images') {
            steps {
                sh 'docker build -t backend-app ./backend'
                sh 'docker build -t frontend-app ./frontend'
            }
        }

        stage('Deploy to EC2') {
            steps {
                sshagent(credentials: ['ec2-ssh-key']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} \
                        "APP_DIR=${APP_DIR} REPO_URL=${REPO_URL} BRANCH=${BRANCH} bash -s" < deploy.sh
                    '''
                }
            }
        }
    }
}
