This isn't the live repo, I'm not daft, but it does give me a chance to play with the Vagrantfile/full integrated development environment

This environment relies on the Puppet server being set up (different repository, different user account). Once that account has been set up it uses r10k to pull data from this particular repository and put it all into place. As you can no doubt see the test curriculum environment contains a few simple services.

The control-repo detailed here will fully build and deploy a jenkins/r10k/puppetdb environment and includes everything necessary to set up an automated puppet server that pulls from any git repository (github is currently used with a manual trigger). The only configuration so far required is to open the puppet server as a root user and use sudo -iu jenkins to allow yourself the opportunity to request a choria certificate: /opt/puppetlabs/puppet/bin/mco choria request_cert . Drop to a second terminal and sign the certificate, and then you can sign out of both.

Currently I'm only using Jenkins with a generic template rather than a pipeline. No doubt I'll add a jenkins file soon.
