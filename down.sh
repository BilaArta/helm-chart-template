#!/bin/bash
echo "Starting Uninstall apps..."

# Pastikan file endpoints.txt ada
if [[ ! -f ./endpoints.txt ]]; then
  echo "Error: ./endpoints.txt file not found."
  exit 1
fi

# Loop untuk setiap endpoint di dalam endpoints.txt
while IFS= read -r endpoint
do

  # Jalankan helm install dengan nama rilis dari setiap endpoint
  helm uninstall "$endpoint"-test
  kubectl delete svc $endpoint-test-app-aither
done < ./endpoints.txt


# chmod +x deploy.sh
# ./deploy.sh