# [Docker image: docker-influxdb](https://hub.docker.com/r/drpsychick/docker-influxdb/)

[![DockerHub build status](https://img.shields.io/docker/build/drpsychick/docker-influxdb.svg)](https://hub.docker.com/r/drpsychick/docker-influxdb/builds/) [![DockerHub build](https://img.shields.io/docker/automated/drpsychick/docker-influxdb.svg)](https://hub.docker.com/r/drpsychick/docker-influxdb/builds/) [![license](https://img.shields.io/github/license/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/blob/master/LICENSE) [![DockerHub pulls](https://img.shields.io/docker/pulls/drpsychick/docker-influxdb.svg)](https://hub.docker.com/r/drpsychick/docker-influxdb/) [![DockerHub stars](https://img.shields.io/docker/stars/drpsychick/docker-influxdb.svg)](https://hub.docker.com/r/drpsychick/docker-influxdb/) [![GitHub stars](https://img.shields.io/github/stars/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb) [![Contributors](https://img.shields.io/github/contributors/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/graphs/contributors)

[![GitHub issues](https://img.shields.io/github/issues/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/issues) [![GitHub closed issues](https://img.shields.io/github/issues-closed/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/issues?q=is%3Aissue+is%3Aclosed) [![GitHub pull requests](https://img.shields.io/github/issues-pr/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/pulls) [![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/drpsychick/docker-influxdb.svg)](https://github.com/drpsychick/docker-influxdb/pulls?q=is%3Apr+is%3Aclosed)

influxdb based on influxdb:alpine image, fully configurable through environment

## Usage

Try it in 3 steps

### 1 create your own influxdb.env
```
docker run --rm -it drpsychick/docker-influxdb:latest --test
docker run --rm -it drpsychick/docker-influxdb:latest --export > influxdb.env
```

### 2 configure it
Edit at least your hostname and output (influxdb or sth. else) in `influxdb.env`:
```
IFX_GLOBAL='reporting-disabled = false\nbind-address = "127.0.0.1:8088"'
```

### 3 test and run it
Run in a separate teminal
```
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/docker-influxdb:latest --test
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/docker-influxdb:latest influxdb --test
docker run --rm -it --env-file influxdb.env --name influxdb-1 drpsychick/docker-influxdb:latest
```

Check your influxdb for new input

## Configure it to your needs
You can use any `IFX_` variable in your `influxdb.env`. They will be added to the config during container startup.

### Example 
```
IFX_COORDINATOR='[coordinator]'
IFX_COORDINATOR_BASE='write-timeout = "30s"\nmax-concurrent-queries = 10\nquery-timeout = "600s"\nlog-queries-after = "10s"'
```

**Beware**:

Docker only support *simple variables*. No ", no ' and especially no newlines in variables.
To define a multiline variable, look at the `IFX_DATA` variable in the example output.

