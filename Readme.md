This isn't the live repo, I'm not daft, but it does give me a chance to play with the Vagrantfile/full integrated development environment

This environment relies on the Puppet server being set up (different repository, different user account) with r10k available - once r10k has pulled this environment down, it will set up everything else it needs.

Currently this repository and the configurations in it are hard coded for our testing environment, and for this github repository. A quick search for gihs (case insensitive) should net you the main points where this needs to be corrected.

The only manual requirements to set up after puppet01 and puppet02 have come online (assuming DNS or Hosts are ok) is to create and sign a mcollective request for the jenkins user in one terminal:

```
sudo -i -u jenkins
/opt/puppetlabs/puppet/bin/mco choria request_cert
```

And sign this request by the puppet master:

```
sudo /opt/puppetlabs/bin/puppet cert sign jenkins.mcollective
```

Additionally, create a Pipeline in jenkins by using Blue Ocean (it's easier - and read only from github is a git repository with an https:// URL).

## Xymon

Xymon will probably require a htpasswd file created to lock down the appropriate sections of Xymon:

```
sudo sh -c "echo -n 'xymonadmin:' >> /etc/nginx/.htpasswd"
sudo sh -c "openssl passwd -apr1 >> /etc/nginx/.htpasswd"
```

HTTP Basic authentication is insecure. It is strongly recommended that you secure this with an acceptable SSL certificate.

## Nginx Configuration

Ensure that the `/site/profile/files/nginx/nginx.conf` file has had the resolver line changed to something suitable for your environment:

```
resolver	$DNS-IP-1 $DNS-IP-2 valid=300s;
```
