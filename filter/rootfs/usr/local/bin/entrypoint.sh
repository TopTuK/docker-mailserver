#!/bin/sh

FILTER_VIRUS_ARGS=""
if [ ${FILTER_VIRUS} == "true" ]
then
    FILTER_VIRUS_ARGS="-wait tcp://${FILTER_VIRUS_HOST}:3310"
fi

if [ "${CONTROLLER_PASSWORD}" == "changeme" ]
then
    # q1 is disabled in rspamd.
    export CONTROLLER_PASSWORD_ENC="q1"
else
    export CONTROLLER_PASSWORD_ENC=`rspamadm pw -e -p ${CONTROLLER_PASSWORD}`
fi

dockerize \
  -template /etc/rspamd/local.d/antivirus.conf.templ:/etc/rspamd/local.d/antivirus.conf \
  -template /etc/rspamd/local.d/worker-controller.inc.templ:/etc/rspamd/local.d/worker-controller.inc \
  -template /etc/rspamd/override.d/redis.conf.templ:/etc/rspamd/override.d/redis.conf \
  -template /etc/rspamd/local.d/classifier-bayes.conf.templ:/etc/rspamd/local.d/classifier-bayes.conf \
  -template /etc/rspamd/local.d/local_bl_domain.inc.templ:/etc/rspamd/local.d/local_bl_domain.inc \
  -template /etc/rspamd/local.d/local_bl_from.inc.templ:/etc/rspamd/local.d/local_bl_from.inc \
  -template /etc/rspamd/local.d/local_bl_ip.inc.templ:/etc/rspamd/local.d/local_bl_ip.inc \
  -template /etc/rspamd/local.d/local_bl_rcpt.inc.templ:/etc/rspamd/local.d/local_bl_rcpt.inc \
  -template /etc/rspamd/local.d/local_wl_domain.inc.templ:/etc/rspamd/local.d/local_wl_domain.inc \
  -template /etc/rspamd/local.d/local_wl_from.inc.templ:/etc/rspamd/local.d/local_wl_from.inc \
  -template /etc/rspamd/local.d/local_wl_ip.inc.templ:/etc/rspamd/local.d/local_wl_ip.inc \
  -template /etc/rspamd/local.d/local_wl_rcpt.inc.templ:/etc/rspamd/local.d/local_wl_rcpt.inc \
  ${FILTER_VIRUS_ARGS} \
  -timeout ${WAITSTART_TIMEOUT} \
  /usr/sbin/rspamd -c /etc/rspamd/rspamd.conf -f
