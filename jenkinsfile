pipeline {
    agent any

    stages {
        stage('Code Clone') {
            steps {
                echo 'Fetch the code from GitHub'
                git branch: 'main', url: 'https://github.com/ansh-saraswat/flask_app.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Docker Build'
                sh "docker build -t flask_app ."
            }
        }
        stage('Push to DockerHub') {
            steps {
                echo "Push to DockerHub"
                withCredentials([usernamePassword(credentialsId:'dockerHub',passwordVariable:'dockerHubPass',usernameVariable:'dockerHubUser')]) {
                sh "docker tag flask_app ${env.dockerHubUser}/flask_app:latest"
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPass}"
                sh "docker push ${env.dockerHubUser}/flask_app:latest"
                }
            }
        }
        stage('Deploy to AWS') {
            steps {
                echo 'Deploy to AWS'
                sh "docker-compose down && docker-compose up -d"
            }
        }
    }
}