This isn't the live repo, I'm not daft, but it does give me a chance to play with the Vagrantfile/full integrated development environment

This environment relies on the Puppet server being set up (different repository, different user account) with r10k available - once r10k has pulled this environment down, it will set up everything else it needs.

Currently this repository and the configurations in it are hard coded for our testing environment, and for this github repository. A quick search for gihs (case insensitive) should net you the main points where this needs to be corrected.

The only manual requirements to set up after puppet01 and puppet02 have come online (assuming DNS or Hosts are ok) is to create and sign a mcollective request for the jenkins user in one terminal:

    sudo -i -u jenkins
    /opt/puppetlabs/puppet/bin/mco choria request_cert

And sign this request by the puppet master:

    sudo /opt/puppetlabs/bin/puppet cert sign jenkins.mcollective

Additionally, create a Pipeline in jenkins by using Blue Ocean (it's easier - and read only from github is a git repository with an https:// URL).

## Xymon

Xymon will probably require a htpasswd file created to lock down the appropriate sections of Xymon:

    sudo sh -c 'printf xymonadmin:$(openssl passwd -apr1)' >> /etc/nginx/.htpasswd.xymon"

HTTP Basic authentication is insecure. It is strongly recommended that you secure this with an acceptable SSL certificate.

## Nginx Configuration

Ensure that the `/site/profile/files/nginx/nginx.conf` file has had the resolver line changed to something suitable for your environment:

    resolver	$DNS-IP-1 $DNS-IP-2 valid=300s;

## Nagios Configuration

The [Nagios Guide](https://assets.nagios.com/downloads/nagioscore/docs/Installing_Nagios_Core_From_Source.pdf) is your best source of information here. However, creating a Nagios installation with the roles here is simple enough for Ubuntu.

Add the role to the node in question:

    node 'nagios01.dev.internal' {
      include role::nagios::server
    }

After a puppet run as completed, the www-data user and www-data group will exist as will the appropriate build tools for Nagios. It is important that this puppet run is executed because fcgiwrap runs as www-data, and will need to be in the nagcmd group to be able to run CGI scripts for Nagios, and we need to compile nagios and nagios-plugins. Note that the puppet run will fail as Nagios Core is not yet installed.

    /opt/puppetlabs/puppet/bin/puppet agent --test

Restart the fcgiwrap service to obtain the new group information:

    service fcgiwrap restart

Download the nagios and nagios-plugins files to a directory on the nagios server (I just drop them into /tmp/), unzip, configure, and install. Note that the ./configure command should be run correctly, this is purely an example.

    cd /tmp
    tar zxf nagios-4.3.1.tar.gz
    tar zxf nagios-plugins-2.2.1.tar.gz
    cd nagios-4.3.1
    ./configure --with-command-group=nagcmd
    --snip--
    make all
    make install
    make install-init
    make install-config
    make install-commandmode

Note: It is not an error that we did not install-webconf here.

    cp -R contrib/eventhandlers/ /usr/local/nagios/libexec/
    chown -R nagios:nagios /usr/local/nagios/libexec/eventhandlers

Verify the configuration before we move on:

    /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

Register with systemd:

    systemctl daemon-reload

Compile and install the nagios plugins:

    cd /tmp/nagios-plugins-2.2.1
    ./configure --with-nagios-user=nagios --with-nagios-group=nagios
    make
    make install

Finally, add a user to /etc/nginx/.htpasswd.nagios:

    sudo sh -c 'printf nagiosadmin:$(openssl passwd -apr1)' >> /etc/nginx/.htpasswd.nagios

And start Nagios:

    service nagios start

That's it for the setup.
