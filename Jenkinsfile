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
                    sh "./gradlew sonarqube"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                // Build the Docker image with a specified tag
                sh """
                docker build -t $DOCKER_IMAGE .
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Use credentials to log in to Docker Hub and push the image
                    withCredentials([usernamePassword(credentialsId: 'Docker_hub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login docker.io -u $DOCKER_USERNAME -p $DOCKER_PASSWORD'
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
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
