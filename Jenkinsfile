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
        ansiblePlaybook become: true, credentialsId: 'ansible-ssh-key', installation: 'ansible', inventory: 'inventory.yaml', playbook: 'deploy-war.yaml'          
      }
    }     
  }
}

