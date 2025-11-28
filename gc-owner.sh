#!/bin/bash

#  1. Control that a PROJECT_ID is provided as an argument
if [ -z "$1" ]; then
    echo "Error: No PROJECT_ID provided."
    echo "Usage: $0 <PROJECT_ID>"
    exit 1
fi

PROJECT_ID=$1
echo "Setting project to: $PROJECT_ID"

ROLE_TO_FIND="roles/owner"

echo "Searching for members with the '$ROLE_TO_FIND' role in project '$PROJECT_ID'..."
echo "-----------------------------------------------"

# 2. Fetch the IAM policy for the specified project
IAM_POLICY=$(gcloud projects get-iam-policy "$PROJECT_ID" --format=json)

# 3. Parse the IAM policy to find members with the specified role
gcloud projects get-iam-policy "$PROJECT_ID" \
    --flatten="bindings[].members" \
    --filter="bindings.role:$ROLE_TO_FIND" \
    --format="csv[no-heading](bindings.members)"
    