pipeline {
    agent {
        label any
    }
    // environment {
    //     ENV = credentials('my-secret-id')
    // }

    tools {
        sonarQube 'SonarScanner'  // Replace with the name you've configured in Jenkins > Global Tool Configuration
    }

    stages {
        stage("SCM Checkout") {
            steps {
                checkout scm
            }
        }

        stage("SonarQube Analysis") {
            steps {
                withSonarQubeEnv() {
                    sh 'sonar-scanner'  // This will use the scanner defined in `tools`
                }
            }
        }

        // stage("Deploy the Multi Container Application") {
        //     steps {
        //         sh 'cp $ENV .env'
        //         sh 'docker-compose pull'
        //         sh 'docker-compose stop web node-app'
        //         sh 'docker-compose rm -f web node-app'
        //         sh 'docker-compose up -d'
        //     }
        // }
    }
}
