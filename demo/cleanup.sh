#!/bin/bash

kubectl delete -f ./application_deploy
helm uninstall consul
helm uninstall vault
helm uninstall mariadb
helm uninstall pq
