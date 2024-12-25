pipeline {
    agent { label 'jenkins-slave' }

    environment {
        DOCKER_IMAGE = 'docker.io/ahmedmaher07/project'
        DEPLOYMENT_YAML = 'deployment.yaml'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Cloning the source code from GitHub"
                git url: 'https://github.com/wolf452/FinalProjectCode.git', branch: 'main'
            }
        }

        stage('Unit Test') {
            steps {
                echo "Running unit tests"
                sh "chmod +x gradlew"
                sh "./gradlew test"
            }
        }

        stage('Build') {
            steps {
                echo "Building the project with Gradle"
                sh "./gradlew build"
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image: $DOCKER_IMAGE"
                sh "docker build -t $DOCKER_IMAGE ."
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'Docker_hub', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        echo "Logging into Docker Hub"
                        sh "docker login docker.io -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        
                        echo "Pushing Docker image to Docker Hub"
                        sh "docker push $DOCKER_IMAGE"
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                echo "Deploying the application to Kubernetes"
                sh "kubectl --kubeconfig=/home/ubuntu/jenkins/.kube/config apply -f $DEPLOYMENT_YAML"
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully."
        }
        failure {
            echo "Pipeline failed. Please check the logs for details."
        }
    }
}
