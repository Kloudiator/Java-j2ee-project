pipeline {
    agent any
    environment {
        PATH = "/usr/local/src/apache-maven/bin:$PATH"
    }
    stages {
        stage('GitHub Clone') {
            steps {
                git branch: 'project03', url: 'https://github.com/Kloudiator/Java-j2ee-project.git'
            }
        }
        stage("SAST SonarQube") {
          steps {
            withSonarQubeEnv('sonarqube') {
              sh 'mvn clean package sonar:sonar'
            }
          }
        }
        stage("Quality Gate") {
          steps {
            timeout(time: 1, unit: 'HOURS') {
              waitForQualityGate abortPipeline: true
            }
          }
        }
        stage('Build Maven') {
            steps {
                sh "mvn clean install package"
            }
        }  
        stage('Deploy Tomcat') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat-admin', 
                path: '', 
                url: 'http://52.53.174.234:8080/')], 
                contextPath: 'project02', 
                war: '**/*.war'                
            }
        }     
    }
    post {
        success {
            emailext to: "rabii.kloudiator@gmail.com",  
            recipientProviders: [developers()], 
            subject: "jenkins Pipe :${currentBuild.currentResult}: ${env.JOB_NAME}", 
            body: "${currentBuild.currentResult}: Job ${env.JOB_NAME}\n More Info can be found here: ${env.BUILD_URL}",
           
            attachLog: true
            
            slackSend message: "Build deployed successfully - Job ${env.JOB_NAME}\n More Info can be found here: ${env.BUILD_URL}"
        }
    }
}

