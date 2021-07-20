ARG INFLUXDB_VERSION=1.8
FROM influxdb:$INFLUXDB_VERSION

ARG TARGETARCH
ARG TOML_URL=https://github.com/DrPsychick/toml_update/releases
ARG TOML_VERSION=0.0.7
RUN curl -sSL -o toml_update_${TOML_VERSION}_Linux_${TARGETARCH}.tar.gz ${TOML_URL}/download/v${TOML_VERSION}/toml_update_${TOML_VERSION}_Linux_${TARGETARCH}.tar.gz \
    && tar -xzf toml_update_${TOML_VERSION}_Linux_${TARGETARCH}.tar.gz toml_update \
    && chmod +x ./toml_update \
    && mv ./toml_update /usr/bin

COPY default.env toml_update.sh /
RUN chmod +x /toml_update.sh

# /var/lib/influxdb must be mounted (create docker volume for it)
VOLUME ["/var/lib/influxdb"]

ENTRYPOINT ["/toml_update.sh"]
CMD ["influxd"]
