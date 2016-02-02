#!/bin/bash
set -xe

TARGET_ROLE=$1

i=0
files=()
for os in centos_7 fedora_22 fedora_23 ubuntu_trusty ubuntu_vivid ubuntu_wily ubuntu_xenial; do
    if [ $(($i % $CIRCLE_NODE_TOTAL)) -eq $CIRCLE_NODE_INDEX ]
    then
	docker pull andrewrothstein/docker-ansible-role:$os
	echo "FROM andrewrothstein/docker-ansible-role:$os" > Dockerfile.$os
	docker build -t andrewrothstein/docker-$TARGET_ROLE -f Dockerfile.$os .
    fi
    ((i=i+1))
done
