#!/bin/sh
for chart in stable/*; do
  if [ -d "${chart}" ]; then

	rm -rf ${chart}/SCALE
	rm -rf ${chart}/charts
    maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
    chartname=$(basename ${chart})
    path="${chart}/${maxfolderversion}"
	rm -rf ${path}/charts
	rm -rf ${path}/Chart.lock
    rm -rf ${path}/values.yaml
	rm -rf app-readme.md
	mkdir -p ${path}/SCALE
    mv ${chart}/item.yaml ${path}/SCALE/item.yaml
    mv ${path}/ix_values.yaml ${path}/SCALE/ix_values.yaml
    mv ${path}/questions.yaml ${path}/SCALE/questions.yaml
    mv ${path}/test_values.yaml ${path}/values.yaml
	mv ${path}/* ${chart}/
	mv ${path}/.helmignore ${chart}/.helmignore || echo ".helmignore not found"
	rm -rf ${path}
  fi
done
