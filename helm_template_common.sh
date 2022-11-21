#!/bin/bash

chart_path=library/common-test

helm template "./$chart_path"
helm lint "./$chart_path"
