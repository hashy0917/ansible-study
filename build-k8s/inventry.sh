#!/bin/sh
if [ -e $PWD/terraform.tfstate ]; then
    ip=`cat $PWD/terraform.tfstate | jq '.resources[].instances[].attributes["default_ip_address"]' 2> /dev/null | sed -e 's/"//g'| sed -ze 's/null\n//g' | head -n 1`
    cat <<EOS
{
    "master"  : [ $ip ]
}
EOS
fi
if [ -e $PWD/terraform.tfstate ]; then
    ip=`cat $PWD/terraform.tfstate | jq '.resources[].instances[].attributes["default_ip_address"]' 2> /dev/null | sed -e 's/"//g'| sed -ze 's/null\n//g' | tail -n 2 | sed -ze 's/\n/,/g'`
    cat <<EOS
{
    "worker"  : [ $ip ]
}
EOS
fi
