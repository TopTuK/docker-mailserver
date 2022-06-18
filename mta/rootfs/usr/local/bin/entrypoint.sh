#!/bin/sh
set -e

postconf myhostname="${MAILNAME}"
postconf mynetworks="${MYNETWORKS}"
postconf recipient_delimiter="${RECIPIENT_DELIMITER}"
postconf smtpd_milters="inet:${RSPAMD_HOST}:11332"
postconf non_smtpd_milters="inet:${RSPAMD_HOST}:11332"

if [ "${FILTER_MIME}" == "true" ]
then
  postconf mime_header_checks=regexp:/etc/postfix/mime_header_checks
fi

if [ "${RELAYHOST}" != "false" ]
then
  postconf relayhost=${RELAYHOST}
  if [ "${RELAY_PASSWD_KEY}" != "false" ]
  then
    postconf smtp_sasl_auth_enable=yes
    postconf smtp_sasl_password_maps=static:${RELAY_PASSWD_KEY}
    postconf smtp_sasl_security_options=${RELAY_OPTIONS}
    postconf smtp_tls_security_level=may
    postconf smtp_use_tls=yes
    postconf smtp_tls_CAfile=/etc/ssl/certs/ca-certificates.crt
    if [ "${HEADER_SIZE_LIMIT}" != "false" ]
    then
      postconf header_size_limit=${HEADER_SIZE_LIMIT}
    fi
  fi
fi

dockerize \
  -template /etc/postfix/mysql-email2email.cf.templ:/etc/postfix/mysql-email2email.cf \
  -template /etc/postfix/mysql-virtual-alias-maps.cf.templ:/etc/postfix/mysql-virtual-alias-maps.cf \
  -template /etc/postfix/mysql-virtual-mailbox-domains.cf.templ:/etc/postfix/mysql-virtual-mailbox-domains.cf \
  -template /etc/postfix/mysql-virtual-mailbox-maps.cf.templ:/etc/postfix/mysql-virtual-mailbox-maps.cf \
  -template /etc/postfix/mysql-recipient-access.cf.templ:/etc/postfix/mysql-recipient-access.cf \
  -template /etc/postfix/mysql-email-submission.cf.templ:/etc/postfix/mysql-email-submission.cf \
  -wait tcp://${MYSQL_HOST}:${MYSQL_PORT} \
  -wait tcp://${MDA_HOST}:2003 \
  -wait tcp://${RSPAMD_HOST}:11332 \
  -wait file://${SSL_CERT} \
  -wait file://${SSL_KEY} \
  -timeout ${WAITSTART_TIMEOUT} \
  /usr/sbin/postfix start-fg
