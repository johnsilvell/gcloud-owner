#!/bin/bash
set -e

#  1. Control that a PROJECT_ID is provided as an argument
if [ -z "$1" ]; then
    echo "Error: No PROJECT_ID provided."
    echo "Usage: $0 <PROJECT_ID>"
    exit 1
fi

PROJECT_ID=$1
echo
echo "Setting project to: $PROJECT_ID"

ROLE_TO_FIND="roles/owner"

# Get the current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")


echo "Searching for members with the '$ROLE_TO_FIND' role in project '$PROJECT_ID'..."
echo
echo "-----------------------------------------------"

# 2. Fetch the IAM policy for the specified project
IAM_POLICY=$(gcloud projects get-iam-policy "$PROJECT_ID" --format=json)

# 3. Parse the IAM policy to find members with the specified role
OWNER_MEMBERS=$(gcloud projects get-iam-policy "$PROJECT_ID" \
    --flatten="bindings[].members" \
    --filter="bindings.role:$ROLE_TO_FIND" \
    --format="csv[no-heading](bindings.members)")

# 3.2 Check if the gcloud command was successful
if [ $? -ne 0]; then
    echo "ERROR: Failed to execute gcloud command. Please check if the permissions for project $PROJECT_ID."
    exit 1
fi

echo "-----------------------------------------------"
echo 

# 4. Save reslults to a file
read -r -p "Do you want to save the results to a file? (y/n): " save_to_file
echo

# Convert answer to lowercase
save_to_file=$(echo "$save_to_file" | tr '[:upper:]' '[:lower:]')

if [[ "$save_to_file" == "y" || "$save_to_file" == "yes" ]]; then

    # Create a filename based on the project ID
    FILENAME="${PROJECT_ID}_owners.txt"

    echo "Saving results to $FILENAME..."

    # Use a Block Redirect to write all output to the file at once
    {
        echo "Results for project: $PROJECT_ID"
        echo "-----------------------------------------------"
        if [ -z "$IAM_POLICY" ]; then
            echo "No members found with the '$ROLE_TO_FIND' role."
        else
            echo "Members with the '$ROLE_TO_FIND' role in project '$PROJECT_ID':"
            echo
            gcloud projects get-iam-policy "$PROJECT_ID" \
                --flatten="bindings[].members" \
                --filter="bindings.role:$ROLE_TO_FIND" \
                --format="csv[no-heading](bindings.members)"
        fi
        echo
        echo "Time of extraction: ${TIMESTAMP}"
        echo "-----------------------------------------------"
    } > "$FILENAME"
    
    echo "Results succesfully saved to $FILENAME."
else
    echo "Results not saved to a file. Finished."
fi
