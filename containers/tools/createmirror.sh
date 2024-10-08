# /bin/bash

cd ../apps
export CONTAINERS=$(find . -name 'values.yaml' | xargs cat | grep "repository" | grep -v "{" | awk -F":" '{ print $2 }' | grep -v '^$' | grep -v "truecharts" | grep -v "ghcr.io" | sort --unique)
cd -
echo "${CONTAINERS}" >> mirrors.txt
for container in ${CONTAINERS}; do
  if [ -d "mirror/${container}" ]; then
    echo "Repository already exists"
  else
    basename=${container##*/}
    echo "processing ${basename}..."
    mkdir -p mirror/${basename}
    cp -Rf tools/template/* mirror/${basename}
    sed -i "s|PLACEHOLDER|${container}|g"  mirror/${basename}/Dockerfile
  fi
done


for container in ${CONTAINERS}; do
  if [ -d "mirror/${container}" ]; then
    basename=${container##*/}
    echo "${basename}..."
  fi
done
