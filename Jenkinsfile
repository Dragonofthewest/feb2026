pipeline {
  agent any

  environment {
    REGISTRY_URL = "local:5000"
    IMAGE_NAME   = "feb2026"
    IMAGE_TAG    = "latest"
    K8S_NAMESPACE = "feb2026"
  }

  stages {
    stage('Checkout') {
      steps {
        checkout([$class: 'GitSCM',
          branches: [[name: '*/master']],
          userRemoteConfigs: [[url: 'https://github.com/Dragonofthewest/feb2026.git']]
        ])
      }
    }

    stage('Build image') {
      steps {
        sh """
          docker build -t ${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG} .
        """
      }
    }

    stage('Push image') {
      steps {
        sh """
          docker push ${REGISTRY_URL}/${IMAGE_NAME}:${IMAGE_TAG}
        """
      }
    }

    stage('Deploy to Kubernetes (Ansible)') {
      steps {
        sh """
          ansible-playbook -i ansible/inventory ansible/playbook.yaml \
            -e registry_url=${REGISTRY_URL} \
            -e image_name=${IMAGE_NAME} \
            -e image_tag=${IMAGE_TAG} \
            -e k8s_namespace=${K8S_NAMESPACE}
        """
      }
    }
  }

  post {
    always {
      sh "docker image ls | grep ${IMAGE_NAME} || true"
    }
  }
}
