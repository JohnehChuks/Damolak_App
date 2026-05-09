// =============================================================
// Jenkinsfile — Damolak App CI/CD Pipeline
// Stages: Clone → Build → Test → Deploy
// =============================================================

pipeline {
    agent any

    environment {
        IMAGE_NAME      = "damolak-app"
        CONTAINER_NAME  = "damolak-app-container"
        APP_PORT        = "3000"
        APP_SERVER_IP   = "99.80.245.28"
    }

    stages {

        stage('Clone') {
            steps {
                echo 'Cloning Damolak App repository...'
                git branch: 'main',
                    url: 'https://github.com/JohnehChuks/Damolak_App_Terraform.git'
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker image...'
                sh """
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
                    docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${IMAGE_NAME}:latest
                """
            }
        }

        stage('Test') {
            steps {
                echo 'Testing Docker container...'
                sh """
                    docker run -d \
                        --name test-${BUILD_NUMBER} \
                        -p 3001:80 \
                        ${IMAGE_NAME}:${BUILD_NUMBER}
                    sleep 5
                    curl -f http://localhost:3001 || exit 1
                    docker stop test-${BUILD_NUMBER}
                    docker rm test-${BUILD_NUMBER}
                """
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying Damolak App...'
                sh """
                    docker stop ${CONTAINER_NAME} || true
                    docker rm ${CONTAINER_NAME} || true
                    docker run -d \
                        --name ${CONTAINER_NAME} \
                        --restart always \
                        -p ${APP_PORT}:80 \
                        ${IMAGE_NAME}:latest
                """
            }
        }

    }

    post {
        success {
            echo 'Damolak App deployed successfully!'
            echo "Access at: http://${APP_SERVER_IP}"
        }
        failure {
            echo 'Pipeline failed! Check logs above.'
        }
    }
}