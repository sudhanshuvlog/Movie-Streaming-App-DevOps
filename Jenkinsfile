pipeline{
    agent {
        label "ec2"
    }
    environment {
        ENV = credentials('my-secret-id')
    }

stages{
    stage("Deploy the Multi Container Application"){
        steps{
          sh 'cp $ENV .env'
          sh 'docker-compose pull' //latest image pull
          sh 'docker-compose stop web node-app'
          sh 'docker-compose rm -f web node-app'
          sh 'docker-compose up -d'
        }
    }
}
}
