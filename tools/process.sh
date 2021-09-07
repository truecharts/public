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
    cp -rf ../templates/app/SCALE output/${basename}/
    cp -rf ${chart}/ci output/${basename}/ || echo "no CI folder detected, continuing..."
    cp -rf ${chart}/templates output/${basename}/
    cp -rf ${chart}/Chart.yaml output/${basename}/Chart.yaml
    cp -rf ${chart}/.helmignore output/${basename}/.helmignore || echo "helmignore not detected, continuing..."
    cp -rf ${chart}/values.yaml output/${basename}/values.yaml
    iconurl=$(cat ${chart}/Chart.yaml | grep -m 1 icon: ) && iconurl=${iconurl/icon: /}
    sed -i "s|PLACEHOLDERICON|${iconurl}|g" output/${basename}/SCALE/item.yaml
    repo=$(cat ${chart}/values.yaml | grep -m 1 repository: ) && repo=${repo/  repository: /}
    tag=$(cat ${chart}/values.yaml | grep -m 1 tag: ) && tag=${tag/  tag: /}
    sed -i "s|PLACEHOLDERREPO|${repo}|g" output/${basename}/SCALE/ix_values.yaml
    sed -i "s|PLACEHOLDERTAG|${tag}|g" output/${basename}/SCALE/ix_values.yaml
    port=$(cat ${chart}/values.yaml | grep -m 1 port: ) && port=${port/        port: /}
    sed -i "s|PLACEHOLDERPORT|${port}|g" output/${basename}/SCALE/questions.yaml
    sed -i "s|PLACEHOLDERNODEPORT|${nodeport}|g" output/${basename}/SCALE/questions.yaml
    sed -i "/^version:/c\version: 1.0.0" output/${basename}/Chart.yaml
    sed -i "/^appVersion:/c\appVersion: 'auto'" output/${basename}/Chart.yaml
    sed -i "s|library-charts.k8s-at-home.com|truecharts.org|g" output/${basename}/Chart.yaml
    sed -i "/name: commonc\- name2: common" output/${basename}/Chart.yaml
    sed -i "/- name:/c\- name: truecharts" output/${basename}/Chart.yaml
    sed -i "/name2: commonc\- name: common" output/${basename}/Chart.yaml
    sed -i "/email:/c\  email: info@truecharts.org
  url: https://truecharts.org" output/${basename}/Chart.yaml
    sed -i "/  version:/c\  version: 6.4.6" output/${basename}/Chart.yaml
    sed -i "s|github.com/k8s-at-home/charts|github.com/truechartsapps|g" output/${basename}/Chart.yaml
    sed -i "s|charts/stable|charts/incubator|g" output/${basename}/Chart.yaml
    sed -i "s|http:|main:|g" output/${basename}/values.yaml
  fi
done
