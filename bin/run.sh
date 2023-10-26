#!/bin/bash
mv run_file/terraform.tfstate.backup run_file/.terraform.tfstate.backup
mv run_file/terraform.tfstate run_file/.terraform.tfstate
rm -rf run_file/*
mv run_file/.terraform.tfstate.backup run_file/terraform.tfstate.backup
mv run_file/.terraform.tfstate run_file/terraform.tfstate
cp -rvf template_file/init/* run_file/
#cp -rvf template_file/vpc/one/* run_file/
cp -rvf template_file/vpc/two/* run_file/
cp -rvf template_file/securitygroup/* run_file/
#cp -rvf template_file/ec2instance/* run_file/
cp -rvf template_file/shell/* run_file/
cp -rvf template_file/alb/* run_file/
cp -rvf template_file/cdn/* run_file/
cp -rvf template_file/memcache/* run_file/
cp -rvf template_file/redis/* run_file/
#cp -rvf template_file/mysql/one/* run_file/
#cp -rvf template_file/mysql/two/* run_file/
cp -rvf template_file/var/* run_file/
#cp -rvf template_file/efs/one/* run_file/
cp -rvf template_file/efs/two/* run_file/
#cp -rvf template_file/postgresql/one/* run_file/
#cp -rvf template_file/postgresql/two/* run_file/
#cp -rvf template_file/docdb/one/* run_file/
#cp -rvf template_file/docdb/two/* run_file/
#cp -rvf template_file/dynamodb/* run_file/
#cp -rvf template_file/eks/* run_file/
#bash bin/autoscaling_done_ec2.sh root 0
#bash bin/autoscaling_done_ec2.sh lookup 1
#bash bin/autoscaling_done_ecs.sh root 0
#bash bin/autoscaling_done_ecs.sh lookup 1
