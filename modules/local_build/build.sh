#!/bin/sh
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$registry_id".dkr.ecr."$region".amazonaws.com
# git clone "$github_url_app"
cd flask-app
docker build -t "$app_name":"$app_tag" .
docker tag "$app_name":"$app_tag" "$ecr_url":"$app_tag"
docker push "$ecr_url":"$app_tag"
