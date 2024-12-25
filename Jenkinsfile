pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'docker.io/ahmedmaher07/project'
        DEPLOYMENT_YAML = 'deployment.yaml'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/wolf452/FinalProjectCode.git', branch: 'main'
            }
        }

      

       
        

        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image for $DOCKER_IMAGE"
                }
                sh """
                docker build -t $DOCKER_IMAGE .
                """
            }
        }

       
        stage('Deploy to Kubernetes') {
            steps {
                script {
                    echo "Deploying application to Kubernetes"
                }
                sh """
                kubectl --kubeconfig=/.kube/config apply -f $DEPLOYMENT_YAML
                """
            }
        }

        stage('Post Action') {
            steps {
                echo "Deployment to Kubernetes completed successfully!"
            }
        }
    }

    post {
        success {
            echo "Pipeline executed successfully."
        }
        failure {
            echo "Pipeline failed. Check the logs for errors."
        }
    }
}
