pipeline {
    agent any

    environment {
        REGISTRY_URL = "localhost:5000"
        IMAGE_NAME   = "feb2026"
        IMAGE_TAG    = "latest"
        K8S_NAMESPACE = "feb2026"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG} ."
            }
        }
        stage('Push Image') {
            steps {
                sh "docker push ${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}"
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl apply -f Deployment.yaml -n ${K8S_NAMESPACE}"
            }
        }
    }

    post {
        always {
            sh "docker image ls | grep ${IMAGE_NAME}"
        }
    }
}
