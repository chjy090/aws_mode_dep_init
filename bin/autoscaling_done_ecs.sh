#!/bin/bash
echo service_name $1
echo target_index $2
rm -rf .cache/*
cp -rvf template_file/ecs/* .cache/
for i in `ls .cache` ; do mv .cache/$i .cache/${1}-${i} ;done
sed -i s/{{apply_name}}/${1}/g .cache/*
sed -i s/{{index_${1}}}/${2}/g .cache/*
cp -rvf .cache/* run_file/
