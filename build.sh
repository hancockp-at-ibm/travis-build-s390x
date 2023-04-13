#!/bin/bash
ARCH=$(uname -m)
git clone https://github.com/travis-ci/travis-build.git
cd ./travis-build
git checkout -t origin/enterprise-3.0
rm -f ./Dockerfile
cp ../Dockerfile.s390x ./Dockerfile
docker build -t quay.io/hancockp/travis:travis-build-ee-s390x-20230413 .
docker login quay.io -u "$ROBOT_USER" -p $ROBOT_TOKEN
docker images
docker push quay.io/hancockp/travis:travis-build-ee-s390x-20230413