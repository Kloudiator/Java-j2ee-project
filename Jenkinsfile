pipeline {
    agent any
    environment {
        PATH = "/usr/local/src/apache-maven/bin:$PATH"
    }
    stages {
	
        stage('GitLab Clone') {
            steps {
                git branch: 'project02', url: 'https://github.com/Kloudiator/Java-j2ee-project.git'
            }
        }

        stage('Build Maven') {
            steps {
                sh "mvn clean install package"
            }
        }
		
        stage('Deploy tomcat') {
            steps {
                deploy adapters: [tomcat9(credentialsId: 'tomcat-admin', 
                path: '', 
                url: 'http://54.183.235.232:8080/')], 
                contextPath: 'project02', 
                war: '**/*.war'
            }
        }
    }
}