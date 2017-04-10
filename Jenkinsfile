pipeline {
  agent
  stages {
    stage('parser') {
      sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" -exec /opt/puppetlabs/puppet/bin/puppet parser validate {} \\;'
    }
  }
}
