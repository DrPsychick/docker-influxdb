# [Docker image: influxdb](https://hub.docker.com/r/drpsychick/influxdb/)

[![Docker image](https://img.shields.io/docker/image-size/drpsychick/influxdb?sort=date)](https://hub.docker.com/r/drpsychick/influxdb/tags) [![DockerHub build status](https://img.shields.io/docker/build/drpsychick/influxdb.svg)](https://hub.docker.com/r/drpsychick/influxdb/builds/) 
[![license](https://img.shields.io/github/license/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/blob/master/LICENSE) [![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/influxdb.svg)](https://hub.docker.com/r/drpsychick/influxdb/) [![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/influxdb.svg)](https://hub.docker.com/r/drpsychick/influxdb/) [![GitHub stars](https://img.shields.io/github/stars/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb) [![Contributors](https://img.shields.io/github/contributors/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/graphs/contributors)

[![GitHub issues](https://img.shields.io/github/issues/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/issues) [![GitHub closed issues](https://img.shields.io/github/issues-closed/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/issues?q=is%3Aissue+is%3Aclosed) [![GitHub pull requests](https://img.shields.io/github/issues-pr/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/pulls) [![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/pulls?q=is%3Apr+is%3Aclosed)
[![Paypal](https://img.shields.io/badge/donate-paypal-00457c.svg?logo=paypal)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FTXDN7LCDWUEA&source=url)
[![GitHub Sponsor](https://img.shields.io/badge/github-sponsor-blue?logo=github)](https://github.com/sponsors/DrPsychick)

influxdb based on influxdb:alpine image, fully configurable through environment

## Usage

Try it in 3 steps

### 1 create your own influxdb.env
```
docker run --rm -it drpsychick/influxdb:latest --test
docker run --rm -it drpsychick/influxdb:latest --export > influxdb.env
```

### 2 configure it
Edit settings in `influxdb.env` to your needs:
```
IFX_GLOBAL=reporting-disabled = true
```

### 3 test and run it
Run in a separate teminal
```
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/influxdb:latest --test
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/influxdb:latest influxd config
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
IFX_COORDINATOR=[coordinator]
IFX_COORDINATOR_BASE=write-timeout = "30s"\nmax-concurrent-queries = 10\nquery-timeout = "600s"\nlog-queries-after = "10s"
```

**Beware**:

Docker only support *simple variables*. No ", no ' and especially no newlines in variables.
To define a multiline variable, look at the `IFX_COORDINATOR_BASE` variable in the example.

