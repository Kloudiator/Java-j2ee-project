pipeline {
  agent any
  environment {
      PATH = "/usr/local/src/apache-maven/bin:$PATH"
  }
  stages {
    stage('GitHub Clone') {
      steps {
        git branch: 'project06', url: 'https://github.com/Kloudiator/Java-j2ee-project.git'
      }
    }
    stage("Build") {
      steps {
        sh 'mvn clean install package'
      }
    }
    stage('Deploy Tomcat with Docker') {
      steps {
        sh 'sudo scp -i /home/ubuntu/.ssh/id_rsa Dockerfile ec2-user@172.31.6.109:/home/ec2-user'
        sh 'sudo scp -i /home/ubuntu/.ssh/id_rsa webapp/target/webapp.war ec2-user@172.31.6.109:/home/ec2-user'
        sh 'sudo ssh -i /home/ubuntu/.ssh/id_rsa ec2-user@172.31.6.109 \"sudo docker image build -t tomcatp06-img .\"'
        sh 'sudo ssh -i /home/ubuntu/.ssh/id_rsa ec2-user@172.31.6.109 \"sudo docker container run --name tomcatp06-container --rm -p 8080:8080 -d tomcatp06-img\"'        
      }
    }     
  }
}

