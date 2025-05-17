pipeline {
  agent { label 'ec2' }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'dev', url: 'https://github.com/sudhanshuvlog/Movie-Streaming-App-DevOps.git'
      }
    }
    stage('Docker Build and Push') {
    steps {
        withCredentials([
        string(credentialsId: 'dockerhub-username', variable: 'DOCKERHUB_USERNAME'),
        string(credentialsId: 'dockerhub-token', variable: 'DOCKERHUB_PASSWORD')
        ]) {
        withEnv([
            'DOCKERHUB_USERNAME=' + env.DOCKERHUB_USERNAME,
            'DOCKERHUB_PASSWORD=' + env.DOCKERHUB_PASSWORD
        ]) {
            sh '''
            echo "$DOCKERHUB_PASSWORD" | docker login -u "$DOCKERHUB_USERNAME" --password-stdin
            docker build -t jinny1/movie-streaming-backend-nodejs:latest .
            docker push jinny1/movie-streaming-backend-nodejs:latest
            docker build -t jinny1/movie-streaming-frontend:latest ./html
            docker push jinny1/movie-streaming-frontend:latest
            docker logout
            '''
        }
        }
    }
    }

  stage('Deploy to Kubernetes') {
  steps {
    withCredentials([
      string(credentialsId: 'db-password', variable: 'DB_PASSWORD'),
      string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
      string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
    ]) {
      withKubeCredentials(kubectlCredentials: [[
        caCertificate: '',
        clusterName: 'EKS-17',
        contextName: '',
        credentialsId: 'k8-token',
        namespace: 'default',
        serverUrl: 'https://1DA2BF960ED718541EE5A2222FC79F18.gr7.ap-south-1.eks.amazonaws.com'
      ]]) {
        sh '''
          kubectl delete secret app-secrets --ignore-not-found
          kubectl create secret generic app-secrets \
            --from-literal=DB_PASSWORD="$DB_PASSWORD" \
            --from-literal=AWS_ACCESS_KEY_ID="$AWS_ACCESS_KEY_ID" \
            --from-literal=AWS_SECRET_ACCESS_KEY="$AWS_SECRET_ACCESS_KEY"
        '''
        sh "kubectl apply -f deploy/configmap.yaml"
        sh "kubectl apply -f deploy/deployment-node-app.yaml"
        sh "kubectl apply -f deploy/service-node-app.yaml"
        sh "sleep 30"
        script {
          def apiUrl = sh(
            script: "kubectl get svc node-app-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'",
            returnStdout: true
          ).trim()

          sh """
            sed 's|\\\${API_URL}|${apiUrl}|g' deploy/webapp-config.yaml | kubectl apply -f -
          """
        }
        sh "kubectl apply -f deploy/deployment-web.yaml"
        sh "kubectl apply -f deploy/service-web.yaml"
      }
    }
  }
}


    stage('Verify Deployment') {
      steps {
        withKubeCredentials(kubectlCredentials: [[
          caCertificate: '',
          clusterName: 'EKS-17',
          contextName: '',
          credentialsId: 'k8-token',
          namespace: 'default',
          serverUrl: 'https://1DA2BF960ED718541EE5A2222FC79F18.gr7.ap-south-1.eks.amazonaws.com'
        ]]) {
          sh "kubectl get svc"
        }
      }
    }
  }
}
