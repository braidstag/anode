#!/bin/bash
ansibleDir=$(dirname $0)

for ip in `cat ${ansibleDir}/server_list`; do
  ssh-copy-id -i ~/.ssh/id_rsa.pub pi@$ip
done
