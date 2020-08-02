#!/bin/bash

set -x
set -e

aws_profile="dev"
account_id=$(aws sts --profile $aws_profile get-caller-identity | jq -r ".Account")
aws_region="eu-west-1"

#tag=$(date +"%y%m%d-%H%M")
tag="latest"

# Build PostgreSQL Docker Image
dbuser=$1
dbpassword=$2
dbname=$3
docker build --build-arg db_user=$dbuser --build-arg db_password=$dbpassword --build-arg db_name=$dbname \
  . -t "$account_id.dkr.ecr.$aws_region.amazonaws.com/postgresql-custom-image:$tag"
# Login to AWS ECR
aws ecr get-login-password --profile $aws_profile --region $aws_region |
  docker login --username AWS --password-stdin "$account_id.dkr.ecr.eu-west-1.amazonaws.com"
# Push the image to ECR
docker push "$account_id.dkr.ecr.$aws_region.amazonaws.com/postgresql-custom-image:$tag"
