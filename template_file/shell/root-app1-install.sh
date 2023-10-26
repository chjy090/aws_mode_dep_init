#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html
export AWS_DEFAULT_REGION=us-east-1
mkdir apply
cd apply
aws s3 cp s3://chjy090-wasdw/root/root .
aws s3 cp s3://chjy090-wasdw/root/server.ini .
chmod a+x root
./root -port 7777
