pipeline {
    agent { label 'jenkins-slave' }
    environment {
        DOCKER_IMAGE = 'docker.io/ahmedmaher07/project'
        DEPLOYMENT_YAML = 'deployment.yaml'
    }
    

        stage('Deploy to Kubernetes') {
            steps {
                sh """
                kubectl --kubeconfig=/home/ubuntu/jenkins/.kube/config apply -f $DEPLOYMENT_YAML
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
