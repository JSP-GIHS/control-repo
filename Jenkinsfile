pipeline {
  agent any

  stages {
    stage('Puppet Parser Validation') {
      steps {
        sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" -exec /opt/puppetlabs/puppet/bin/puppet parser validate {} \\;'
      }
    }
    stage('Puppet Lint Validation') {
      steps {
        sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" -exec /usr/bin/puppet-lint {} \\;'
      }
    }
  }
  post {
    success {
      sh '/opt/puppetlabs/puppet/bin/mco rpc r10k deploy environment=production'
    }
  }
}
