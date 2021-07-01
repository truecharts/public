#!/usr/bin/env bash
set -eu

# This script will do some basic processing from k8s-at-home to TrueCharts
nodeport=3700
for chart in input/*; do
  if [ -d "${chart}" ]; then
    nodeport=$((nodeport+1))
    basename=$(basename ${chart})
    echo "processing ${chart} using nodeport $nodeport"
    mkdir -p output/${basename}
    cp -rf placeholder/SCALE output/${basename}/
    cp -rf placeholder/ci output/${basename}/
    cp -rf ${chart}/templates output/${basename}/
    cp -rf ${chart}/Chart.yaml output/${basename}/Chart.yaml
    cp -rf ${chart}/.helmignore output/${basename}/.helmignore
    cp -rf ${chart}/values.yaml output/${basename}/values.yaml
    iconurl=$(cat ${chart}/Chart.yaml | grep icon: ) && iconurl=${iconurl/icon: /}
    sed -i "s|PLACEHOLDERICON|${iconurl}|g" output/${basename}/SCALE/item.yaml
    repo=$(cat ${chart}/values.yaml | grep repository: ) && repo=${repo/  repository: /}
    tag=$(cat ${chart}/values.yaml | grep tag: ) && tag=${tag/  tag: /}
    sed -i "s|PLACEHOLDERREPO|${repo}|g" output/${basename}/SCALE/ix_values.yaml
    sed -i "s|PLACEHOLDERTAG|${tag}|g" output/${basename}/SCALE/ix_values.yaml
    port=$(cat ${chart}/values.yaml | grep port: ) && port=${port/        port: /}
    sed -i "s|PLACEHOLDERPORT|${port}|g" output/${basename}/SCALE/questions.yaml
    sed -i "s|PLACEHOLDERNODEPORT|${nodeport}|g" output/${basename}/SCALE/questions.yaml
    configpath=$(cat ${chart}/values.yaml | grep mountPath: ) && configpath=${configpath/    mountPath: /}
    sed -i "s|PLACEHOLDERCONFIGPATH|${configpath}|g" output/${basename}/SCALE/questions.yaml
    sed -i "/^version:/c\version: 1.0.0" output/${basename}/Chart.yaml
    sed -i "/^appVersion:/c\appVersion: 'auto'" output/${basename}/Chart.yaml
    sed -i "s|library-charts.k8s-at-home.com|truecharts.org|g" output/${basename}/Chart.yaml
    sed -i "/name: common/c\- name2: common" output/${basename}/Chart.yaml
    sed -i "/- name:/c\- name: truecharts" output/${basename}/Chart.yaml
    sed -i "/name2: common/c\- name: common" output/${basename}/Chart.yaml
    sed -i "/email:/c\  email: info@truecharts.org" output/${basename}/Chart.yaml
    sed -i "/  version:/c\  version: 6.4.6" output/${basename}/Chart.yaml
    sed -i "s|github.com/k8s-at-home/charts|github.com/truecharts/apps|g" output/${basename}/Chart.yaml
    sed -i "s|charts/stable|charts/incubator|g" output/${basename}/Chart.yaml
    sed -i "s|http:|main:|g" output/${basename}/values.yaml
  fi
done
