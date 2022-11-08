#!/bin/bash

curr_dir=${pwd}

common_test_path=library/common-test

helm dependency build "$common_test_path"
cd "$common_test_path"
helm unittest -f "tests/*/*.yaml" .
cd "$curr_dir"
