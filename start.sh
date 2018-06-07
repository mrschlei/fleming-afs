#!/bin/sh

# Redirect logs to stdout and stderr for docker reasons.
ln -sf /dev/stdout /var/apache2/log/access_log
ln -sf /dev/stderr /var/apache2/log/error_log

# apache and virtual host secrets
ln -sf /secrets/httpd/httpd.conf /etc/httpd/conf/httpd.conf
#ln -sf /secrets/apache2/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
ln -sf /secrets/httpd/cosign.conf /etc/httpd/conf.d/cosign.conf

# SSL secrets
ln -sf /secrets/ssl/USERTrustRSACertificationAuthority.pem /etc/pki/tls/private/USERTrustRSACertificationAuthority.pem
ln -sf /secrets/ssl/AddTrustExternalCARoot.pem /etc/pki/tls/private/AddTrustExternalCARoot.pem
ln -sf /secrets/ssl/sha384-Intermediate-cert.pem /etc/pki/tls/private/sha384-Intermediate-cert.pem

#if [ -f /secrets/app/local.start.sh ]
#then
#  /bin/sh /secrets/app/local.start.sh
#fi

## Rehash command needs to be run before starting apache.
c_rehash /etc/pki/tls/certs >/dev/null

cd /var/www/html

#drush @sites cc all --yes
#drush up --no-backup --yes

service httpd start