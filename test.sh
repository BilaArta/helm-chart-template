#!/bin/bash
echo "Starting test.sh..."

# Pastikan file endpoints.txt ada
if [[ ! -f ./endpoints.txt ]]; then
  echo "Error: ./endpoints.txt file not found."
  exit 1
fi

echo "Input app name:"
read name
name=${name:-app-aither}

echo "Input namespace :"
read namespace
namespace=${namespace:-helm-template}

echo "Input image repository:"
read image
image=${image:-ayg03/aither}



# Loop untuk setiap endpoint di dalam endpoints.txt
while IFS= read -r endpoint
do
    echo "Deploying: $endpoint"
    # helm upgrade --install "$endpoint"-dev my-app -f "$values_file" 
    echo "name: $name; namespace: $namespace; image: $image;"
done < ./endpoints.txt


# chmod +x deploy.sh
# ./deploy.sh