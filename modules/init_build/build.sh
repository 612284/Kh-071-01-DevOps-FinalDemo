#!/bin/sh
# sudo yum update -y
sudo yum install -y unzip
sudo yum install -y git
docker info
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws sts get-caller-identity
aws ecr get-login-password --region "${region}" | docker login --username AWS --password-stdin "${registry_id}".dkr.ecr."${region}".amazonaws.com
git clone "${github_url_iac}"
cd Kh-071-01-DevOps-FinalDemo/app
ls -la
docker build -t "${app_name}":"${app_tag}" .
docker tag "${app_name}":"${app_tag}" "${ecr_url}":"${app_tag}"
docker push "${ecr_url}":"${app_tag}"
