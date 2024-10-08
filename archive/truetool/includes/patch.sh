#!/bin/bash

patchv22120(){
echo "Applying 22.12 HotPatch 1"

( wget -q -P /tmp https://github.com/truecharts/truetool/raw/main/patch/2212/HP1.patch && echo "download completed" || echo "download failed" ) && ( patch -N -s -p0 -d /usr/lib/python3/dist-packages/middlewared/ &>/dev/null < /tmp/HP1.patch && echo "patch completed" || echo "Patch Already Applied" ) && rm -rf /tmp/HP1.patch

echo "Applying 22.12 HotPatch 2"
( wget -q -P /tmp https://github.com/truecharts/truetool/raw/main/patch/2212/HP2.patch && echo "download completed" || echo "download failed" ) && ( patch -N -s -p0 -d /usr/lib/python3/dist-packages/middlewared/ &>/dev/null < /tmp/HP2.patch && echo "patch completed" && restartmiddleware=yes || echo "Patch Already Applied" ) && rm -rf /tmp/HP2.patch
}
export -f patchv22120




hotpatch(){
echo "Starting hotpatcher..."
restartmiddleware=no
if (( "$scaleVersion" == 22120 )); then
  patchv22120
else
  echo "No hotpatch available for your version, congratulations!"
fi

if [[ "$restartmiddleware" == "yes" ]]; then
  middlewareRestart
fi
restartmiddleware=no
}
export -f hotpatch
