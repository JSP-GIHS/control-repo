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
	sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" | grep -v "./modules" | xargs /usr/bin/puppet-lint --fail-on-warnings --no-puppet_url_without_modules-check'
      }
    }
    stage('r10k Branch Deployment') {
      steps {
        sh "/opt/puppetlabs/puppet/bin/mco rpc r10k deploy environment=${env.BRANCH_NAME}"
      }
    }
    stage('Puppet Agent Run') {
      steps {
        sh '/opt/puppetlabs/puppet/bin/mco puppet runall 5'
      }
    }
  }
}
