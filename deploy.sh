#!/bin/bash

# required Travis-ci secret variables (all other variables to be set in .travis.yml)
# DOCKER_PASS, DOCKER_USER

# login to docker
echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin &> /dev/null || exit 1

# push dev image (only latest)
if [ "$TRAVIS_BRANCH" = "dev" -a "$INFLUXDB_VERSION" = "alpine" ]; then
  echo "build and push docker image(s) for version $IMAGE:dev (platforms $PLATFORMS)"
  docker buildx build --progress plain --platform $PLATFORMS --build-arg INFLUXDB_VERSION=$INFLUXDB_VERSION \
    -t $IMAGE:dev --push .
fi

# push master images (not when it's a pull request)
if [ "$TRAVIS_BRANCH" = "master" -a "$TRAVIS_PULL_REQUEST" = "false" ]; then
  # tag including ALPINE version
  if [ "$INFLUXDB_VERSION" = "alpine" ]; then
    echo "build and push docker image(s) for version $IMAGE:latest (platforms $PLATFORMS)"
    docker buildx build --progress plain --platform $PLATFORMS --build-arg INFLUXDB_VERSION=$INFLUXDB_VERSION \
      -t $IMAGE:latest --push .
  else
    # build single platform and load it into local docker repository, so we can launch it and determine version
    docker buildx build --progress plain --platform linux/amd64 --build-arg INFLUXDB_VERSION=$INFLUXDB_VERSION \
      -t $IMAGE --load .
    export VERSION=$(docker run --rm $IMAGE cat /etc/alpine-release)

    # build for all platforms again and push with correct version tag
    echo "build and push docker image(s) for version $IMAGE:$INFLUXDB_VERSION-$VERSION (platforms $PLATFORMS)"
    docker buildx build --progress plain --platform $PLATFORMS --build-arg INFLUXDB_VERSION=$INFLUXDB_VERSION \
      -t $IMAGE:$INFLUXDB_VERSION-$VERSION --push .
  fi
fi
