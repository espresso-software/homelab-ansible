#!/bin/bash

set -e

TEMPLATE="netplan/template.yml"
OUTPUT_DIR="netplan/output"

while getopts ":i:e:g:a:" opt; do
  case ${opt} in
    i )
      VLAN_ID=$OPTARG
      ;;
    e )
      ETHERNET_DEVICE=$OPTARG
      ;;
    a )
      ADDR_SUFF=$OPTARG
      ;;
    \? )
      echo "Invalid option: $OPTARG" 1>&2
      ;;
  esac
done

GATEWAY=10.${VLAN_ID}.0.1
ADDRESS=10.${VLAN_ID}.${ADDR_SUFF}

# Default gateway based on VLAN ID

if [ -z "$VLAN_ID" ] || [ -z "$ETHERNET_DEVICE" ] || [ -z "$ADDR_SUFF" ]; then
  echo "Usage: $0 -i <VLAN_ID> -e <ETHERNET_DEVICE> -a <ADDRESS>"
  exit 1
fi

# Create new netplan configuration file from template
mkdir -p $OUTPUT_DIR
OUTPUT_FILE="$OUTPUT_DIR/netplan-$ADDRESS.yaml"
sed -e "s/{{VLAN_ID}}/$VLAN_ID/g" \
    -e "s/{{ETHERNET_DEVICE}}/$ETHERNET_DEVICE/g" \
    -e "s/{{GATEWAY}}/$GATEWAY/g" \
    -e "s/{{ADDRESS}}/$ADDRESS/g" \
    $TEMPLATE > $OUTPUT_FILE
echo "Netplan configuration file created: $OUTPUT_FILE"