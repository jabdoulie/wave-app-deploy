pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ton-utilisateur/ton-image'  // Nom de l'image Docker sur Docker Hub
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

        stage('Install Backend Dependencies') {
            steps {
                echo 'Installation des dépendances PHP via Composer'
                sh 'composer install --no-interaction --prefer-dist'
            }
        }

        stage('Install Frontend Dependencies') {
            steps {
                echo 'Installation des dépendances JavaScript via npm'
                sh 'npm install'
            }
        }

        stage('Build Frontend') {
            steps {
                echo 'Compilation du frontend avec npm run build'
                sh 'npm run build'
            }
        }

        stage('Run Backend Tests') {
            steps {
                echo 'Exécution des tests backend avec PHPUnit'
                sh 'php artisan test'
            }
        }
    }
}
