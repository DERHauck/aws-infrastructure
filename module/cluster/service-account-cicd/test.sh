#!/usr/bin/env bash
NAMESPACE=gitlab
SERVICE_ACCOUNT=cicd




SECRET=$(kubectl -n "${NAMESPACE}" get secret | grep ${SERVICE_ACCOUNT} | awk '{print $1}')
TOKEN=$(kubectl -n "${NAMESPACE}" describe secret "${SECRET}" | grep token: | awk '{print $2}')


kubectl --token="${TOKEN}" auth can-i --list
#TOKENS=$(kubectl create token cicd-samv4p2 -n "${NAMESPACE}")
#kubectl --token="${TOKENS}" auth can-i --list
#kubectl --token="${TOKEN}" get secrets