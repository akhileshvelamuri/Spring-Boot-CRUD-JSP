pipeline {
    agent any
    
    tools {
        jdk 'JDK-8'
        maven 'Maven-3.6'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-credentials',
                    url: 'https://github.com/akhileshvelamuri/Spring-Boot-CRUD-JSP.git'
            }
        }
        
        stage('Build') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }
        
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        
        stage('Archive') {
            steps {
                archiveArtifacts artifacts: '**/target/*.war, **/target/*.jar', 
                                 fingerprint: true
            }
        }
    }
    
    post {
        success {
            echo 'Build completed successfully!'
        }
        failure {
            echo 'Build failed!'
        }
    }
}