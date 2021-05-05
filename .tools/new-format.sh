#!/bin/sh
for chart in stable/*; do
  if [ -d "${chart}" ]; then
    maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
    chartname=$(basename ${chart})
    path="${chart}/${maxfolderversion}"
	mkdir -p ${path}/SCALE
    rm -rf ${path}/values.yaml
	rm -rf app-readme.md
    mv ${chart}/item.yaml ${path}/SCALE/item.yaml
    mv ${path}/ix_values.yaml ${path}/SCALE/ix_values.yaml
    mv ${path}/questions.yaml ${path}/SCALE/questions.yaml
    mv ${path}/test_values.yaml ${path}/values.yaml
	mv ${path}/* ${chart}/
	rm -rf ${path}
  fi
done
