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
      
      stage('Update Deployment File') {
        environment {
            GIT_REPO_NAME = "sq1projects"
            GIT_USER_NAME = "system-sudo"
        }
        steps {
            withCredentials([string(credentialsId: 'github', variable: 'GITHUB_TOKEN')]) {
                sh '''
                    git config user.email "systemtesting48@gmail.com"
                    git config user.name "system-sudo"
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s/replaceImageTag/${BUILD_NUMBER}/g" sq1projects/deploymentservice.yaml
                    git add sq1projects/deploymentservice.yaml
                    git commit -m "Update deployment image to version ${BUILD_NUMBER}"
                    git push https://${GITHUB_TOKEN}@github.com/${GIT_USER_NAME}/${GIT_REPO_NAME} HEAD:main
                '''
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
