#!/bin/bash

: '
Copyright (C) 2019 IBM Corporation
Licensed under the Apache License, Version 2.0 (the “License”);
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an “AS IS” BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
    Rafael Sene <rpsene@br.ibm.com> - Initial implementation.
    Peter Hancock <hancockp@uk.ibm.com> - Cut down from file to i8nstall docker and build travis 
'

function install-docker {
    # It can install Docker on s390x, ignore the power in the name.
    if [ ! -d docker_on_power ]; then
        git clone https://github.com/Unicamp-OpenPower/docker_on_power.git
    fi
    ./docker_on_power/install_docker.sh
    touch /etc/docker/daemon.json
    echo '
    {"dns": ["9.0.132.50", "9.0.134.50", "9.20.136.11", "9.20.136.25", "9.12.16.2", "9.0.128.50"],
    "storage-driver": "overlay2"}' >> /etc/docker/daemon.json
    sed -i -- 's/#   StrictHostKeyChecking ask/StrictHostKeyChecking no/g' /etc/ssh/ssh_config
    service docker restart
}

install-docker
