# Library Chart for iX Official Catalog iX Chart

**WARNING: THIS CHART IS NOT MEANT TO BE INSTALLED DIRECTLY**

This is a [Helm Library Chart](https://helm.sh/docs/topics/library_charts/#helm). It's purpose is for grouping common logic between the k8s@home charts. 

Since a lot of charts follow the same pattern this library was built to reduce maintenance cost between the charts that use it and try achieve a goal of being DRY.

## Introduction

This chart provides common template helpers which can be used to develop new charts using [Helm](https://helm.sh) package manager.
