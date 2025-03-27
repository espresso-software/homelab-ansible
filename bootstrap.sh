#!/bin/bash

set -e

extra_args=""
vault_password_file="~/vault"
playbook="bootstrap"

while getopts ":v:l:t:p:" opt; do
  case ${opt} in
    v )
      vault_password_file=$OPTARG
      ;;
    l )
      hosts=$OPTARG
      extra_args="$extra_args -l $hosts"
      ;;
    t )
      tags=$OPTARG
      extra_args="$extra_args -t $tags"
      ;;
    p )
      playbook=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done

ansible-playbook -v --vault-password-file $vault_password_file -i inventory/bootstrap.yml $playbook.yml $extra_args