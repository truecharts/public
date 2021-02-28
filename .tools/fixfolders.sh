for chart in charts/*; do
  if [ -d "${chart}" ]; then
      maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
      maxchartversion=$(cat ${chart}/${maxfolderversion}/Chart.yaml | grep "^version: " | awk -F" " '{ print $2 }')
      chartname=$(basename ${chart})
      echo "Processing: ${chart} - folder: ${maxfolderversion} - version: ${maxchartversion}"
      helm dependency update --skip-refresh ${chart}/${maxfolderversion}
      if [ "${maxfolderversion}" != "${maxchartversion}" ]; then
          mv -f ${chart}/${maxfolderversion} ${chart}/${maxchartversion}
          echo "renamed ${chart}/${maxfolderversion} to ${chart}/${maxchartversion}"
      fi
  fi
done
