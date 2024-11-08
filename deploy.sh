#!/bin/bash
echo "Starting deploy.sh..."

# Pastikan file endpoints.txt ada
if [[ ! -f ./endpoints.txt ]]; then
  echo "Error: ./endpoints.txt file not found."
  exit 1
fi

echo "Deployment - Input app name:"
read name
name=${name:-app-aither}

echo "Deployment - Input namespace :"
read namespace
namespace=${namespace:-helm-template}

echo "Deployment - Input image repository:"
read image
image=${image:-ayg03/aither}

echo "Ingress - Input ClassName (Controller):"
read className
className=${className:-nginx-aither}

param="--set namespace=$namespace \
      --set image.repository=$image \
      --set ingress.className=$className \
      --set ingress.annotations.kubernetes\.io/ingress\.class=$className"

kubectl create configmap aither-config --from-file=my-app/configmap/config -n $namespace
kubectl create configmap aither-settings-config --from-file=my-app/configmap/settings -n $namespace
kubectl create configmap hosts-acdb-configmap --from-file=my-app/configmap/hosts -n $namespace

# Loop untuk setiap endpoint di dalam endpoints.txt
while IFS= read -r endpoint
do

  echo "Deploying: $endpoint"
  paramName="--set nameOverride=$endpoint-$name"
  # Jalankan helm install dengan nama rilis dari setiap endpoint
  # helm upgrade --install "$endpoint"-dev my-app -f "$values_file"
  helm upgrade --install $endpoint-test ./my-app $paramName $param
  echo "================================================"

done < ./endpoints.txt


# chmod +x deploy.sh
# ./deploy.sh