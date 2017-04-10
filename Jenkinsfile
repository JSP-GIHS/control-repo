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
	sh 'echo $(find . -type f -name "*.pp" \\( -exec /usr/bin/puppet-lint --fail-on-warnings --with-filename {} \\; -o -quit \\) 2>&1 ) | grep -v RANDOM'
      }
    }
  }
  post {
    success {
      sh '/opt/puppetlabs/puppet/bin/mco rpc r10k deploy environment=production'
    }
  }
}
