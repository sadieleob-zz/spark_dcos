#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\e[32m'
BLINK='\e[5m'
YELLOW='\e[93m'


## Uninstalling Spark
dcos package uninstall spark --yes &> /dev/null

printf "${RED}The Spark dispatcher persists state in ZooKeeper, so to fully uninstall the DC/OS Apache Spark package, you must:${NC}\n${RED}Navigate to http://<dcos-url>/exhibitor.${NC}\n${GREEN}Delete the znode corresponding to your instance of Spark. By default, this node is spark_mesos_Dispatcher${NC}
${GREEN}Reference: https://docs.d2iq.com/mesosphere/dcos/services/spark/2.9.0-2.4.3/uninstall/${NC}"
