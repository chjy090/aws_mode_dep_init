#!/bin/bash
#export AWS_ACCESS_KEY_ID=
#export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=us-east-1
#export AWS_SESSION_TOKEN=
if [ -f /bin/terraform ] ; then
  echo "terraform已安装"
else
  wget https://releases.hashicorp.com/terraform/1.5.6/terraform_1.5.6_linux_amd64.zip
  unzip terraform_1.5.6_linux_amd64.zip
  rm -rf terraform_1.5.6_linux_amd64.zip
  chmod a+x terraform
  mv terraform /bin/terraform
fi
bash bin/run.sh
cd run_file/
#export https_proxy=http://127.0.0.1:7890
terraform init
#unset https_proxy
terraform plan
terraform apply -auto-approve
cd ../
