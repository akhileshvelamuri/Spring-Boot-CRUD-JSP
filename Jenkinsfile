properties([
    pipelineTriggers([
        githubPush()
    ])
])

pipeline {
    agent any
    
    tools {
        jdk 'JDK-8'
        maven 'Maven-3.6'
    }
    
    environment {
        // SonarQube project configuration
        SONAR_PROJECT_KEY = 'spring-boot-crud-jsp'
        SONAR_PROJECT_NAME = 'Spring Boot CRUD JSP'
    }
    
    stages {
        stage('Checkout') {
            steps {
                echo '📥 Checking out code from GitHub...'
                git branch: 'master',
                    credentialsId: 'github-credentials',
                    url: 'https://github.com/akhileshvelamuri/Spring-Boot-CRUD-JSP.git'
            }
        }
        
        stage('Build') {
            steps {
                echo '🔨 Compiling application...'
                bat 'mvn clean compile'
            }
        }
        
        stage('Run Tests with Coverage') {
            steps {
                echo '🧪 Running unit tests with JaCoCo coverage...'
                bat '''
                    mvn test ^
                        org.jacoco:jacoco-maven-plugin:0.8.7:prepare-agent ^
                        org.jacoco:jacoco-maven-plugin:0.8.7:report
                '''
            }
            post {
                always {
                    echo '📊 Publishing test results...'
                    
                    // Publish JUnit test results
                    junit allowEmptyResults: true, 
                          testResults: '**/target/surefire-reports/*.xml'
                    
                    // Publish HTML coverage report
                    publishHTML([
                        allowMissing: true,
                        alwaysLinkToLastBuild: true,
                        keepAll: true,
                        reportDir: 'target/site/jacoco',
                        reportFiles: 'index.html',
                        reportName: 'JaCoCo Coverage Report'
                    ])
                    
                    // Publish JaCoCo visualization
                    script {
                        try {
                            jacoco(
                                execPattern: '**/target/jacoco.exec',
                                classPattern: '**/target/classes',
                                sourcePattern: '**/src/main/java',
                                exclusionPattern: '**/*Test*.class'
                            )
                        } catch (Exception e) {
                            echo "⚠️ JaCoCo visualization failed: ${e.message}"
                        }
                    }
                }
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                echo '🔍 Running SonarQube code analysis...'
                withSonarQubeEnv('SonarQube') {
                    bat """
                        mvn sonar:sonar ^
                            -Dsonar.projectKey=%SONAR_PROJECT_KEY% ^
                            -Dsonar.projectName="%SONAR_PROJECT_NAME%" ^
                            -Dsonar.host.url=http://localhost:9000 ^
                            -Dsonar.java.binaries=target/classes ^
                            -Dsonar.coverage.jacoco.xmlReportPaths=target/site/jacoco/jacoco.xml
                    """
                }
            }
        }
        
        stage('Quality Gate') {
            steps {
                echo '⏳ Waiting for SonarQube Quality Gate result...'
                timeout(time: 5, unit: 'MINUTES') {
                    script {
                        try {
                            def qg = waitForQualityGate()
                            if (qg.status != 'OK') {
                                echo "⚠️ Quality Gate Status: ${qg.status}"
                                echo "📊 View detailed report: http://localhost:9000/dashboard?id=${SONAR_PROJECT_KEY}"
                                // Uncomment to fail build on quality gate failure
                                // error "Quality Gate failed: ${qg.status}"
                            } else {
                                echo "✅ Quality Gate passed!"
                            }
                        } catch (Exception e) {
                            echo "⚠️ Quality Gate check failed or timed out: ${e.message}"
                            echo "Continuing build anyway..."
                        }
                    }
                }
            }
        }
        
        stage('Package') {
            steps {
                echo '📦 Creating WAR/JAR package...'
                bat 'mvn package -DskipTests'
            }
        }
        
        stage('Archive Artifacts') {
            steps {
                echo '📁 Archiving build artifacts...'
                archiveArtifacts artifacts: '**/target/*.war, **/target/*.jar', 
                                 fingerprint: true,
                                 allowEmptyArchive: false
            }
        }
    }
    
    post {
        always {
            echo '📊 Build Summary:'
            echo "   Workspace: ${env.WORKSPACE}"
            echo "   Build Number: ${env.BUILD_NUMBER}"
        }
        success {
            echo ''
            echo '✅ ========================================='
            echo '✅ BUILD COMPLETED SUCCESSFULLY!'
            echo '✅ ========================================='
            echo ''
            echo '📊 View Reports:'
            echo "   • Test Results: ${env.BUILD_URL}testReport/"
            echo "   • Coverage: ${env.BUILD_URL}JaCoCo_Coverage_Report/"
            echo "   • SonarQube: http://localhost:9000/dashboard?id=${SONAR_PROJECT_KEY}"
            echo ''
            echo '📦 Artifacts archived and ready for deployment'
        }
        failure {
            echo ''
            echo '❌ ========================================='
            echo '❌ BUILD FAILED!'
            echo '❌ ========================================='
            echo ''
            echo "🔍 Check console output: ${env.BUILD_URL}console"
        }
    }
}
