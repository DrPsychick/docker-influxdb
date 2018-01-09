FROM influxdb:alpine

COPY default.env /
COPY influxdb.conf.tmpl /
COPY envreplace.sh /
RUN chmod +x /envreplace.sh

# /var/lib/influxdb must be mounted (create docker volume for it)
VOLUME ["/var/lib/influxdb"]

ENTRYPOINT ["/envreplace.sh"]
CMD ["influxd"]
