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
