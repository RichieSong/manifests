#!/bin/sh
kubectl get pod --all-namespaces | egrep "CrashLoopBackOff|ImagePullBackOff|Evicted" | egrep -v "kube-system|monitor"  > ./a.txt
while read line
do
ns=`echo $line | cut -d " " -f1`
deploy=`echo $line | cut -d " " -f2| rev|cut -d- -f 3- | rev`
if [ "$ns" != "kube-system" ];then
kubectl delete deploy -n  $ns $deploy
kubectl delete svc -n  $ns $deploy

fi
done < ./a.txt

kubectl get pod --all-namespaces
