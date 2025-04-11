pipeline {
    agent any  // Utilise n'importe quel agent disponible

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
    }
}
