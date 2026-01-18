pipeline {
  agent none

  options {
    timestamps()
  }

  environment {
    REGISTRY = "jinny1"
    BACKEND_IMAGE = "movie-streaming-backend-nodejs"
    FRONTEND_IMAGE = "movie-streaming-frontend"
    KUBE_NAMESPACE = "default"
  }

  stages {

    stage('Checkout') { // job1
      agent { label 'ec2' }
      steps {
        checkout scm
      }
    }

    stage('Unit Tests') {
      agent {dockerContainer 'jinny1/jenkins-slave-with-npm-support'}
      steps {
        sh '''
          npm install
          npm test
        '''
      }
    }

  stage('Set Image Tag') {
  agent { label 'ec2' }
  steps {
    script {
      env.IMAGE_TAG = "${env.BUILD_NUMBER}-${env.GIT_COMMIT.take(7)}"
      echo "Using IMAGE_TAG=${env.IMAGE_TAG}"
    }
  }
  }

    // stage('SonarQube Analysis') {
    //   environment {
    //     SONAR_TOKEN = credentials('sonarqube-token')
    //   }
    //   steps {
    //     sh '''
    //       sonar-scanner \
    //       -Dsonar.projectKey=movie-streaming \
    //       -Dsonar.sources=. \
    //       -Dsonar.host.url=http://sonarqube:9000 \
    //       -Dsonar.login=$SONAR_TOKEN
    //     '''
    //   }
    // }

    // stage('Quality Gate') {
    //   steps {
    //     timeout(time: 5, unit: 'MINUTES') {
    //       waitForQualityGate abortPipeline: true
    //     }
    //   }
    // }

    stage('Docker Build & Push') {
      agent { label 'ec2' }
      steps {
        withCredentials([
          usernamePassword(credentialsId: 'dockerhub-creds',
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS')
        ]) {
          sh '''
            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

            docker build -t $REGISTRY/$BACKEND_IMAGE:$IMAGE_TAG .
            docker build -t $REGISTRY/$FRONTEND_IMAGE:$IMAGE_TAG ./html

            docker push $REGISTRY/$BACKEND_IMAGE:$IMAGE_TAG
            docker push $REGISTRY/$FRONTEND_IMAGE:$IMAGE_TAG

            docker logout
          '''
        }
      }
    }

    stage('Manual Approval (PROD)') {
      agent { label 'ec2' }
      steps {
        input message: "Approve deployment to PRODUCTION?"
      }
    }

    stage('Deploy to Kubernetes') {
      agent { label 'ec2' }
      steps {
        withCredentials([
          string(credentialsId: 'db-password', variable: 'DB_PASSWORD'),
          string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
          string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
          sh '''
            kubectl apply -f deploy/configmap.yaml

            kubectl create secret generic app-secrets \
              --from-literal=DB_PASSWORD=$DB_PASSWORD \
              --from-literal=AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
              --from-literal=AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
              --dry-run=client -o yaml | kubectl apply -f -

            kubectl apply -f deploy/deployment-node-app.yaml
            kubectl apply -f deploy/service-node-app.yaml
            kubectl set image deployment/node-app node-app=$REGISTRY/$BACKEND_IMAGE:$IMAGE_TAG
            kubectl rollout restart deployment node-app
            sleep 20
          '''

          script {
            def apiUrl = sh(
              script: "kubectl get svc node-app-service -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'",
              returnStdout: true
            ).trim()

            echo "Resolved API_URL=${apiUrl}"

            sh """
              sed 's|\\\${API_URL}|${apiUrl}|g' deploy/webapp-config.yaml | kubectl apply -f -
            """
          }

          sh '''
            kubectl apply -f deploy/deployment-web.yaml
            kubectl apply -f deploy/service-web.yaml
            kubectl set image deployment/web web=$REGISTRY/$FRONTEND_IMAGE:$IMAGE_TAG
            kubectl rollout restart deployment web
          '''
        }
      }
    }
  }

  post {
    failure {
      node('ec2') {
      sh '''
        kubectl rollout undo deployment/node-app || true
        kubectl rollout undo deployment/web || true
      '''
    }
    }

    success {
      echo "Production deployment successful"
    }
  }
}
