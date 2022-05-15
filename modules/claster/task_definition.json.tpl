[
  {
    "essential": true,
    "memory": 256,
    "name": "worker-${env}-${app_name}",
    "cpu": 3,
    "image": "${ecr_url}:${app_tag}",
    "portMappings": [
      {
        "hostPort": 0,
        "protocol": "tcp",
        "containerPort": 5000
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${env}-${app_name}-group",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${env}-${app_name}-stream"
       }
     },
    "environment": []
  }
]
