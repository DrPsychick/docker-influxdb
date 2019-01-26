ARG ALPINE_VERSION=alpine
FROM influxdb:$ALPINE_VERSION

COPY default.env /
COPY influxdb.conf.tmpl /
COPY envreplace.sh /
RUN chmod +x /envreplace.sh

# /var/lib/influxdb must be mounted (create docker volume for it)
VOLUME ["/var/lib/influxdb"]

ENTRYPOINT ["/envreplace.sh"]
CMD ["influxd"]
