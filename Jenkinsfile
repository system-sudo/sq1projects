pipeline {
    agent any

    environment {
        dockerImageName = 'systemtesting48/sq1'
        registryCredential = 'docker'
        dockerImage = ''
    }

    stages {
        stage('Cloning Git') {
            steps {
                git(
                    url: 'https://github.com/system-sudo/sq1projects.git',
                    branch: 'main',
                    credentialsId: 'github'
                )
            }
        }

        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build(dockerImageName)
                }
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', registryCredential) {
                        dockerImage.push("$BUILD_NUMBER")
                        dockerImage.push('latest')
                    }
                }
            }
        }
      
     
        stage('Deploy to Kubernetes') {
    steps {
        withCredentials([file(credentialsId: 'kubecred', variable: 'KUBECONFIG')]) {
            sh '''
                echo "Using kubeconfig at: $KUBECONFIG"
                kubectl config get-contexts
                kubectl get pods
                kubectl apply -f deploymentservice.yaml
            '''
        }
    }
}

        
    }
}
