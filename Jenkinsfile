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
        stage('SAST SonarQube') {
            steps {
                sh '''mvn clean verify sonar:sonar \\
                    -Dsonar.projectKey=project02 \\
                    -Dsonar.host.url=http://54.193.181.253/:9000 \\
                    -Dsonar.login=sqp_ce324451d9e42b3ef2caa48ce13967c332128b9a'''
            }
        }       
        stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
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
                url: 'http://54.241.91.118:8080/')], 
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

