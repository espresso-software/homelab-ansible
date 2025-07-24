#!/bin/bash

set -e

TEMPLATE="netplan/template.yml"
OUTPUT_DIR="netplan/output"

while getopts ":a:e:i:f:g:s:" opt; do
  case ${opt} in
    i )
      VLAN_ID=$OPTARG
      ;;
    e )
      ETHERNET_DEVICE=$OPTARG
      ;;
    a )
      ADDRESS=$OPTARG
      ;;
    g )
      GATEWAY=$OPTARG
      ;;
    s )
      SUBNET_MASK=$OPTARG
      ;;
    f )
      HOST=$OPTARG
      ;; 
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done

if [ -z "$VLAN_ID" ] || [ -z "$ETHERNET_DEVICE" ] || [ -z "$ADDRESS" ] || [ -z "$GATEWAY" ] || [ -s "$SUBNET_MASK" ]; then
  echo "Usage: $0 -i <VLAN_ID> -e <ETHERNET_DEVICE> -a <ADDRESS> -g <GATEWAY> -s <SUBNET_MASK> [-f <HOST>]"
  exit 1
fi
if [ -z "$HOST" ]; then
  HOST=$ADDRESS
fi

# Create new netplan configuration file from template
mkdir -p $OUTPUT_DIR
OUTPUT_FILE="$OUTPUT_DIR/netplan-$HOST.yaml"
sed -e "s/{{VLAN_ID}}/$VLAN_ID/g" \
    -e "s/{{ETHERNET_DEVICE}}/$ETHERNET_DEVICE/g" \
    -e "s/{{GATEWAY}}/$GATEWAY/g" \
    -e "s/{{ADDRESS}}/$ADDRESS/g" \
    -e "s/{{SUBNET_MASK}}/$SUBNET_MASK/g" \
    $TEMPLATE > $OUTPUT_FILE
echo "Netplan configuration file created: $OUTPUT_FILE"