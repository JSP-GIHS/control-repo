pipeline {
  agent any

  //
  // Simple Jenkinsfile for testing. Note that we assume
  // some default paths based on Ubuntu 16.04 test servers
  //
  // Servers with profile::jenkins will automatically
  // install puppet-lint via Ruby Gems
  //
  // Note that the Agent Run is perhaps superfluous if the
  // environment being run is a testing environment. This
  // is a simple file, and more creativity may be needed
  // to sort that stage out.
  //
  stages {
    stage('Puppet Parser Validation') {
      steps {
        sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" -exec /opt/puppetlabs/puppet/bin/puppet parser validate {} \\+'
      }
    }
    stage('Puppet Lint Validation') {
      steps {
	sh '/usr/bin/find . -path ./modules -prune -o -name "*.pp" | grep -v "./modules" | xargs /usr/local/bin/puppet-lint --fail-on-warnings --no-puppet_url_without_modules-check'
      }
    }
    stage('ERB Template Validation') {
      steps {
        sh '/usr/bin/find . -path ./modules -prune -o -name "*.erb" | grep -v "./modules" | xargs -I {} sh -c "echo -n \"{}: \" ; erb -P -x -T \"-\" {} | ruby -c"'
      }
    }
    stage('r10k Branch Deployment') {
      steps {
        sh "/opt/puppetlabs/puppet/bin/mco rpc r10k deploy environment=${env.BRANCH_NAME}"
      }
    }
    stage('Puppet Agent Run') {
      steps {
        sh "/opt/puppetlabs/puppet/bin/mco puppet runall 5"
      }
    }
  }
}
