pipeline {
    agent { label 'jenkins-slave' }
    environment {
        DOCKER_IMAGE = 'docker.io/ahmedmaher07/project'
        DEPLOYMENT_YAML = 'deployment.yaml'
    }
    stages {
        stage('Checkout') {
            steps {
                // Pull the code from the main branch of the repository
                git url: 'https://github.com/wolf452/FinalProjectCode.git', branch: 'main'
            }
        }

        stage('Build') {
            steps {
                // Build the project using Gradle
                sh "chmod +x gradlew"
                sh "./gradlew build"
            }
        }

        stage('Test') {
            steps {
                // Run unit tests using Gradle
                sh "./gradlew test"
            }
        }

        stage('SonarQube Analysis') {
            steps {
                // Run SonarQube analysis
                withSonarQubeEnv('sonar') { 
                    sh "./gradlew sonarqube"  // تأكد من أن هذا الأمر مكتمل
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build and push the Docker image
                sh """
                docker build -t $DOCKER_IMAGE .
                docker push $DOCKER_IMAGE
                """
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Apply the deployment configuration to the Kubernetes cluster
                sh """
                kubectl --kubeconfig=/home/ubuntu/jenkins/.kube/config apply -f $DEPLOYMENT_YAML
                """
            }
        }

        stage('Post Action') {
            steps {
                // Notify that the deployment was successful
                echo "Deployment to Kubernetes completed successfully!"
            }
        }
    }

    post {
        success {
            // Message displayed on successful pipeline execution
            echo "Pipeline executed successfully."
        }
        failure {
            // Message displayed on pipeline failure
            echo "Pipeline failed. Check the logs for errors."
        }
    }
}
