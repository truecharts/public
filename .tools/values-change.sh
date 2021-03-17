for chart in charts/*; do
  if [ -d "${chart}" ]; then
      maxfolderversion=$(ls -l ${chart} | grep ^d | awk '{print $9}' | tail -n 1)
      chartname=$(basename ${chart})
      echo "Processing: ${chart} - folder: ${maxfolderversion} - version: ${maxchartversion}"

      mv -f ${chart}/${maxfolderversion}/values.yaml ${chart}/${maxfolderversion}/ix_values.yaml
  fi
done
