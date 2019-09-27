#!/bin/bash
#coding:utf8
name=$1
namespace=$2
echo
cat << EOF
#########################################
Used: ./start.sh [name] [namespace]
    -- name 名称[必填项]
    -- namespace 空间名称[非必填,默认monitor]

#########################################
EOF
echo

if [ "$name" == "" ];then
	echo -e "\033[32m ERROR:缺少参数,请输入一个命名参数! \033[0m"
fi
if [ "$namespace" == "" ];then
	namespace="monitor"        
fi
if [ "$name" != "" -a $namespace != "" ];then

echo -e "\033[32m NameSpace: $namespace \033[0m"

helm ls --all

helm del --purge $name

helm install --name $name --namespace $namespace .

else
echo -e "\033[32m 名称或空间名为空,未有任何有效操作 \033[0m"
fi
