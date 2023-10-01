pipeline {
    agent any
    environment {
        PATH = "/usr/local/src/apache-maven/bin:$PATH"
    }
    stages {
        stage('GitHub Clone') {
            steps {
                git branch: 'project02', url: 'https://github.com/Kloudiator/Java-j2ee-project.git'
            }
        }
        stage('SonarQube Analysis') {
            tools {
                sonarQube 'SonarQube Scanner 2.16'
            }
            steps {
                withSonarQubeEnv('SonarQube Scanner') {
                    sh "mvn clean verify sonar:sonar -Dsonar.projectKey=project02"
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
                url: 'http://13.52.100.232:8080/')], 
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

