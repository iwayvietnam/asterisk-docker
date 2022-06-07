FROM alpine:latest
LABEL maintainer="Truong Anh Tuan <tuanta@iwayvietnam.com>"

ENV LANG=C.UTF-8
ENV LC_ALL C.UTF-8

RUN set -e \
&& apk add --update --quiet \
         asterisk \
         asterisk-alsa \
         asterisk-cdr-mysql \
         asterisk-curl \
         asterisk-sounds-en \
         asterisk-sounds-moh \
         asterisk-speex \
         asterisk-srtp \
         asterisk-openrc \
         asterisk-opus \
         mysql \
         asterisk-sample-config >/dev/null \
&& asterisk -U asterisk &>/dev/null \
&& sleep 5s \
&& [ "$(asterisk -rx "core show channeltypes" | grep PJSIP)" != "" ] && : \
     || rm -rf /usr/lib/asterisk/modules/*pj* \
&& pkill -9 ast \
&& sleep 1s \
&& truncate -s 0 \
     /var/log/asterisk/messages \
     /var/log/asterisk/queue_log || : \
&& mkdir -p /var/spool/asterisk/fax \
&& chown -R asterisk: /var/spool/asterisk \
&& rm -rf /var/run/asterisk/* \
          /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*

EXPOSE 5060/udp 5060/tcp
VOLUME /var/lib/asterisk/sounds /var/lib/asterisk/keys /var/lib/asterisk/phoneprov /var/spool/asterisk /var/log/asterisk

ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
