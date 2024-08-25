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
          sh 'docker-compose pull' 
          sh 'docker-compose up -d'
        }
    }
}
}
