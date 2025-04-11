pipeline {
    agent any  // Utilise n'importe quel agent disponible

    environment {
        DOCKER_IMAGE = 'abdoulie/wave-image'  // Nom de l'image Docker sur Docker Hub
        DOCKER_TAG = 'latest'  // Tag de l'image (peut être dynamique)
        DOCKER_CREDENTIALS = 'docker-hub-credentials'  // Credentials Docker Hub configuré dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                echo 'Clonage du code depuis le dépôt Git'
                checkout scm  // Utilisation du SCM configuré dans Jenkins
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    echo 'Construction de l\'image Docker'
                    sh '''
                        docker build -t $DOCKER_IMAGE:$DOCKER_TAG .
                    '''
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    echo 'Push de l\'image Docker vers Docker Hub'
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh '''
                            docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                            docker tag wave-image:latest docker.io/$DOCKER_USERNAME/wave-image:latest
                            docker push $DOCKER_IMAGE:$DOCKER_TAG
                        '''
                    }
                }
            }
        }
    }
}
