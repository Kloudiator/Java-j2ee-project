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
        script {
          withCredentials([sshUserPrivateKey(credentialsId: 'ansible-ssh-key', keyFileVariable: 'SSH_KEY')]) {
              def remoteServer = "172.31.6.109"
              def sshUser = 'devops-ansible'
              sh "sudo scp -i $SSH_KEY Dockerfile ${sshUser}@${remoteServer}:/home/${sshUser}"
              sh "sudo scp -i $SSH_KEY webapp/target/webapp.war ${sshUser}@${remoteServer}:/home/${sshUser}"
              sh "sudo ssh -i $SSH_KEY ${sshUser}@${remoteServer} 'sudo docker image build -t tomcatp06-img .'"
              sh "sudo ssh -i $SSH_KEY ${sshUser}@${remoteServer} 'sudo docker rm tomcatp06-container -f'"              
              sh "sudo ssh -i $SSH_KEY ${sshUser}@${remoteServer} 'sudo docker container run --name tomcatp06-container --rm -p 8080:8080 -d tomcatp06-img'"              
          }
        }        
      }
    }     
  }
}

