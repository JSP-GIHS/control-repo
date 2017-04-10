pipeline {
  agent any

  stages {
    stage('parser') {
      steps {
        sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" -exec /opt/puppetlabs/puppet/bin/puppet parser validate {} \\;'
      }
    }
  }
  post {
    success {
      sh '/opt/puppetlabs/puppet/bin/mco r10k deploy environment -p'
    }
  }
}
