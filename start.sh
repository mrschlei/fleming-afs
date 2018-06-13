#!/bin/sh

# Redirect logs to stdout and stderr for docker reasons.
ln -sf /dev/stdout /var/log/httpd/access_log
ln -sf /dev/stderr /var/log/httpd/error_log

# apache and virtual host secrets
ln -sf /secrets/httpd/httpd.conf /etc/httpd/conf/httpd.conf
#ln -sf /secrets/apache2/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
#ln -sf /secrets/httpd/cosign.conf /usr/local/apache2/conf.d/cosign.conf

# SSL secrets
ln -sf /secrets/ssl/USERTrustRSACertificationAuthority.pem /etc/pki/tls/private/USERTrustRSACertificationAuthority.pem
ln -sf /secrets/ssl/AddTrustExternalCARoot.pem /etc/pki/tls/private/AddTrustExternalCARoot.pem
ln -sf /secrets/ssl/sha384-Intermediate-cert.pem /etc/pki/tls/private/sha384-Intermediate-cert.pem

if [ -f /secrets/app/local.start.sh ]
then
  /bin/sh /secrets/app/local.start.sh
fi

## Rehash command needs to be run before starting apache.
c_rehash /etc/pki/tls/certs >/dev/null

#cd /usr/local/apache2/htdocs

#drush @sites cc all --yes
#drush up --no-backup --yes

#/usr/local/apache2/bin/apachectl start
while true; do sleep 2; done
