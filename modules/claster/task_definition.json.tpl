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
        "awslogs-group": "claster-${env}-${app_name}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "claster-stream-${env}-${app_name}"
       }
     },
    "environment": []
  }
]
