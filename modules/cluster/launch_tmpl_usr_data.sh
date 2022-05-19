#!/bin/bash
echo ECS_CLUSTER=cluster-${env}-${app_name} >> /etc/ecs/ecs.config
# sudo amazon-linux-extras install epel -y
# sudo yum install stress -y
# # sudo stress --cpu 1
