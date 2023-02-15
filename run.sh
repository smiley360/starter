#!/bin/bash

# Start the services in the background
docker-compose up -d

while [ ! -f ./db.created ]; do
    echo "Waiting for file..."
    sleep 2
done

# Stop and remove the containers
echo "Tear it down"
docker-compose down
rm db.created

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

# now, starts with replacing the port in tmp/db/postgresql.conf for the port number
old_line="#port = 5432                            # (change requires restart)"
new_line="port = 5433"
file="./tmp/db/postgresql.conf"

echo "looking into $file"
if grep -q "$old_line" "$file"; then
  echo "Found"
  # Replace the line in-place
  sed -i "s/$old_line/$new_line/g" "$file"
else
  echo "Not found and append"
  # Append the new line if the old line does not exist
  echo "$new_line" >> "$file"
fi

#run the container again
echo "**************************************\r"
echo "**  final run                       **\r"
echo "**************************************\r"

docker compose up &
