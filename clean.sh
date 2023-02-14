#!/bin/bash

# shut down all dockers
docker compose down

declare -a image_array

# Store all Docker images with the specified name in an array
image_array=($(docker images | grep -w "starter-web" | awk '{print $3}'))
image_array+=($(docker images | grep -w "postgres" | awk '{print $3}'))

# Loop through the array and remove each image
for image in "${image_array[@]}"
do
    echo "removing images = $image"
    docker rmi "$image"
done

