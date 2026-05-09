// =============================================================
// Jenkinsfile — Damolak App CI/CD Pipeline
// Stages: Clone → Build → Test → Deploy to App Server
// =============================================================

pipeline {
    agent any

    environment {
        IMAGE_NAME      = "damolak-app"
        CONTAINER_NAME  = "damolak-app-container"
        APP_PORT        = "3000"
        APP_SERVER_IP   = "10.0.1.176"
        APP_SERVER_USER = "ubuntu"
        APP_KEY         = "/var/lib/jenkins/damolak_app_keypair.pem"
    }

    stages {

        stage('Clone') {
            steps {
                echo 'Cloning Damolak App repository...'
                git branch: 'developer',
                    url: 'https://github.com/JohnehChuks/Damolak_App.git'
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
                echo 'Deploying to App Server...'
                sh """
                    # Save Docker image to tar file
                    docker save ${IMAGE_NAME}:latest | gzip > /tmp/${IMAGE_NAME}.tar.gz

                    # Copy image to App server
                    scp -i ${APP_KEY} \
                        -o StrictHostKeyChecking=no \
                        /tmp/${IMAGE_NAME}.tar.gz \
                        ${APP_SERVER_USER}@${APP_SERVER_IP}:/tmp/${IMAGE_NAME}.tar.gz

                    # Load and run image on App server
                    ssh -i ${APP_KEY} \
                        -o StrictHostKeyChecking=no \
                        ${APP_SERVER_USER}@${APP_SERVER_IP} '
                            docker load < /tmp/${IMAGE_NAME}.tar.gz
                            docker stop damolak-app-container || true
                            docker rm damolak-app-container || true
                            docker run -d \
                                --name damolak-app-container \
                                --restart always \
                                -p 3000:80 \
                                damolak-app:latest
                        '
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