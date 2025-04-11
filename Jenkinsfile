pipeline {
    agent any  // Utilise n'importe quel agent disponible

    stages {
        stage('Checkout') {
            steps {
                echo 'Clonage du code depuis le dépôt Git'
                checkout scm  // Utilisation du SCM configuré dans Jenkins
            }
        }
    }
}
