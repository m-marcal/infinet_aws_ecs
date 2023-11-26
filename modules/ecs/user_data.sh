#!/bin/bash

# The cluster name is mandatory as stated in the ECS docs from AWS
# In the other hand this ECS_BACKEND_HOST, I'm not sure. 
# The tutorial from AWS Academy use it on the lab cluster, but no much background is given. 

echo ECS_CLUSTER='${ecs_cluster_name}' >> /etc/ecs/ecs.config
echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config;