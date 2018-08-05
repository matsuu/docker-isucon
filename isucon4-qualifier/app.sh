#!/bin/bash

if test $1 = "start"; then
    docker-compose --file "docker-compose-${2}.yml" up --build -d nginx;
elif test $1 = "stop"; then
    docker-compose --file "docker-compose-${2}.yml" stop;
else 
    echo "引数はstartかstopのみ許されている.";
    exit 1;
fi
