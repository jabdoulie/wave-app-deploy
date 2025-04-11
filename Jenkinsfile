pipeline {
    agent any  // Utilise n'importe quel agent disponible

    environment {
        SCANNER_HOME = tool 'sonar-scanner'
        SONAR_CREDENTIALS_ID = 'Sonar-token'
        SONARQUBE_URL = 'http://192.168.8.14:9000'  // URL de SonarQube
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

        // Ajouter l'étape SonarQube Scan ici
        stage('SonarQube Analysis') {
            steps {
                script {
                    echo 'Analyse du code avec SonarQube'
                    withSonarQubeEnv('sonarqube') {
                        // Assurez-vous d’avoir un projet Maven/Gradle ou un script adapté
                        sh '''
                            $SCANNER_HOME/bin/sonar-scanner \
                            -Dsonar.projectKey=wave-project \
                            -Dsonar.host.url=$SONARQUBE_URL \
                            -Dsonar.login=$SONARQUBE_TOKEN
                        '''
                    }
                }
            }
        }

        // Ajouter l'étape Trivy Scan pour l'analyse de sécurité de l'image Docker
        stage('Trivy Docker Image Scan') {
            steps {
                script {
                    echo 'Analyse de l\'image Docker avec Trivy'
                    sh '''
                        trivy image --no-progress --exit-code 1 --severity HIGH,CRITICAL $DOCKER_IMAGE:$DOCKER_TAG
                    '''
                }
            }
        }
    }
}
