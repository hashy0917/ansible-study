#!/bin/sh
if [ -e $PWD/terraform.tfstate ]; then
    master_ip=`cat $PWD/terraform.tfstate | jq '.resources[].instances[].attributes["default_ip_address"]' 2> /dev/null | sed -e 's/"//g'| sed -ze 's/null\n//g' | head -n 1`
    node_ip=`cat $PWD/terraform.tfstate | jq '.resources[].instances[].attributes["default_ip_address"]' 2> /dev/null | sed -e 's/"//g'| sed -ze 's/null\n//g' | tail -n 2 | sed -ze 's/\n/,/g'`
    cat <<EOS
{
    "master"  : [ $master_ip ],
    "worker"  : [ $node_ip ]
}
EOS
fi
