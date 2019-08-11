#!/bin/bash
ansibleDir=$(dirname $0)

for ip in `cat ${ansibleDir}/server_list`; do
  ansible-playbook -i $ip, hostname.yml --extra-vars "ansible_user=pi ansible_password=raspberry" --sudo

done
