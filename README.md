# [Docker image: influxdb](https://hub.docker.com/r/drpsychick/influxdb/)
influxdb based on the official influxdb images, multiple architectures (amd64,arm64/v8), cloud ready, fully configurable through environment

[![Docker image](https://img.shields.io/docker/image-size/drpsychick/influxdb?sort=date)](https://hub.docker.com/r/drpsychick/influxdb/tags) 
[![Build Status](https://img.shields.io/circleci/build/github/DrPsychick/docker-influxdb)](https://app.circleci.com/pipelines/github/DrPsychick/docker-influxdb)
[![license](https://img.shields.io/github/license/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/blob/master/LICENSE) 
[![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/influxdb.svg)](https://hub.docker.com/r/drpsychick/influxdb/) 
[![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/influxdb.svg)](https://hub.docker.com/r/drpsychick/influxdb/) 
[![GitHub stars](https://img.shields.io/github/stars/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb) 
[![Contributors](https://img.shields.io/github/contributors/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/graphs/contributors)

[![GitHub issues](https://img.shields.io/github/issues/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/issues) [![GitHub closed issues](https://img.shields.io/github/issues-closed/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/issues?q=is%3Aissue+is%3Aclosed) [![GitHub pull requests](https://img.shields.io/github/issues-pr/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/pulls) [![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/pulls?q=is%3Apr+is%3Aclosed)
[![Paypal](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FTXDN7LCDWUEA&source=url)
[![GitHub Sponsor](https://img.shields.io/badge/github-sponsor-blue?logo=github)](https://github.com/sponsors/DrPsychick)


## Usage

### UPDATE 2021-07-08 - BC breaking change!
The image is now using non-alpine base images and a small go utility ([toml_update](https://github.com/DrPsychick/toml_update)) to read, modify and write a valid toml configuration file.
* no more multi-line variables
* variable name order is no longer relevant
* -> configuration environment is much simpler and more "readable"
```shell
# before
entrypoint_cmd=/entrypoint.sh
conf_templates="influxdb.conf.tmpl:/etc/influxdb/influxdb.conf"
conf_var_prefix=IFX_
# can be overwritten, to add names or to reorder names
conf_vars_influxconf=${conf_vars_influxconf:-'IFX_GLOBAL IFX_META IFX_DATA IFX_COORDINATOR IFX_RETENTION IFX_SHARD-PRECREATION IFX_MONITOR IFX_SUBSCRIBER IFX_HTTP IFX_GRAPHITE IFX_COLLECTD IFX_OPENTSDB IFX_UDP IFX_CONTINUOUS_QUERIES'}
IFX_GLOBAL=reporting-disabled = false
IFX_COORDINATOR=[coordinator]
IFX_COORDINATOR_BASE=write-timeout = "30s"\nmax-concurrent-queries = 10\nquery-timeout = "600s"\nlog-queries-after = "10s"
# after
CONF_UPDATE=/etc/influxdb/influxdb.conf
CONF_PREFIX=IFX
IFX_GLOBAL1=reporting-disabled=false
IFX_COORDINATOR1=coordinator.write-timeout="30s"
IFX_COORDINATOR2=coordinator.max-concurrent-queries=10
IFX_COORDINATOR3=coordinator.query-timeout="600s"
IFX_COORDINATOR_WHATEVER=coordinator.log-queries-after="10s"
```

Try it in 3 steps

### 1 create your own influxdb.env
```
docker run --rm -it drpsychick/influxdb:latest cat /default.env > influxdb.env
# check default configuration:
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/influxdb:latest influxd config
```

### 2 configure it
Edit settings in `influxdb.env` to your needs:
* do not use spaces after the first `=` unless in quotes
```
IFX_GLOBAL=reporting-disabled=true
```

### 3 test and run it
Run in a separate teminal
```
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/influxdb:latest --test
docker run --rm -it --env-file influxdb.env --name influxdb-1 --publish 8086:8086 drpsychick/influxdb:latest
```

Test the connection
```
curl http://localhost:8086/query --data-urlencode "q=SHOW DATABASES"
```

## Configure it to your needs
You can use any `IFX_` variable in your `influxdb.env`. They will be added to the config during container startup.

### Example 
```
IFX_VAR1=coordinator.write-timeout="30s"
IFX_ANY_OTHER_NAME=coordinator.max-concurrent-queries=10
```

**Beware**:

Docker only support *simple variables*. No ", no ' and especially no newlines in variables.
