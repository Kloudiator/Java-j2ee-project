pipeline {
  agent any
  environment {
      PATH = "/usr/local/src/apache-maven/bin:$PATH"
  }
  stages {
    stage('GitHub Clone') {
      steps {
        git branch: 'project05', url: 'https://github.com/Kloudiator/Java-j2ee-project.git'
      }
    }
    stage("Build") {
      steps {
        sh 'mvn clean install package'
      }
    }
    stage('Deploy Tomcat with Ansible') {
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: 'ansible-ssh-key', keyFileVariable: 'keyfile', usernameVariable: 'SSH_USER')]) {
          sh 'cp \$keyfile "devops-ansible_id"'
        }

        ansiblePlaybook credentialsId: 'ansible-ssh-key', inventory: 'inventory.yaml', playbook: 'deploy-war.yaml', extras: '-e "StrictHostKeyChecking=no"'         
        sh 'cp ssh*.key gogo.key'      
      }
    }     
  }
}

