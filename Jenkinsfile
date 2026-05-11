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

        stage('Get App Server IP') {
            steps {
                echo 'Using configured App Server Elastic IP...'

                script {
                    env.APP_SERVER_IP = "54.77.250.195"
                }

                echo "App Server IP: ${APP_SERVER_IP}"
            }
        }

        stage('Deploy') {
            steps {
                echo 'Deploying to App Server...'

                sh """
                    docker save ${IMAGE_NAME}:latest | gzip > /tmp/${IMAGE_NAME}.tar.gz

                    scp -i ${APP_KEY} \
                        -o StrictHostKeyChecking=no \
                        /tmp/${IMAGE_NAME}.tar.gz \
                        ${APP_SERVER_USER}@${APP_SERVER_IP}:/tmp/${IMAGE_NAME}.tar.gz

                    rm -f /tmp/${IMAGE_NAME}.tar.gz

                    ssh -i ${APP_KEY} \
                        -o StrictHostKeyChecking=no \
                        ${APP_SERVER_USER}@${APP_SERVER_IP} '
                            docker load < /tmp/${IMAGE_NAME}.tar.gz
                            rm -f /tmp/${IMAGE_NAME}.tar.gz

                            docker stop ${CONTAINER_NAME} || true
                            docker rm ${CONTAINER_NAME} || true

                            docker run -d \
                                --name ${CONTAINER_NAME} \
                                --restart always \
                                -p ${APP_PORT}:80 \
                                ${IMAGE_NAME}:latest
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