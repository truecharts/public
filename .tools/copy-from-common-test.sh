for chart in charts/*; do
  if [ -d "${chart}" ]; then
      maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
      chartname=$(basename ${chart})
      echo "Processing: ${chart} - folder: ${maxfolderversion} - version: ${maxchartversion}"
      if [ "${maxfolderversion}" != "${maxchartversion}" ]; then
	      rm -Rf ${chart}/${maxfolderversion}/charts/*.tgz
          cp -f library/common-test/charts/* ${chart}/${maxfolderversion}/charts/
      fi
  fi
done
