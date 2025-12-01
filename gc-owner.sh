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

# 2. Parse the IAM policy to find members with the specified role
OWNER_MEMBERS=$(gcloud projects get-iam-policy "$PROJECT_ID" --format=json \
    --flatten="bindings[].members" \
    --filter="bindings.role:$ROLE_TO_FIND AND NOT bindings.members:serviceAccount:service-*" \
    --format="csv[no-heading](bindings.members)")

# 2.2 Check if the gcloud command was successful
if [ $? -ne 0 ]; then
    echo "ERROR: Failed to execute gcloud command. Please check the permissions for project $PROJECT_ID." >&2
    exit 1
fi

# 2.3 Display the results
if [ -z "$OWNER_MEMBERS" ]; then
    echo "No members found with the '$ROLE_TO_FIND' role (Google Service Agents excluded)."
else
    echo "$OWNER_MEMBERS"
fi

echo "-----------------------------------------------"
echo 

# 4. Save reslults to a file
read -r -p "Do you want to save the results to a file? (y/n): " save_to_file
echo

# Convert answer to lowercase
save_to_file=$(echo "$save_to_file" | tr '[:upper:]' '[:lower:]')

if [[ "$save_to_file" == "y" || "$save_to_file" == "yes" ]]; then

    # 4.1 Create a directory for output files if it doesn't exist
    REPORT_DIR="${PROJECT_ID}_reports_$(date +%Y%m%d)"
    
    # 4.1.2 Check if directory already exists
    if [ -d "$REPORT_DIR" ]; then
        echo "Directory $REPORT_DIR already exists. Using existing directory."
        echo
    else
        mkdir -p "$REPORT_DIR"
        echo "Created directory $REPORT_DIR for output files."
        echo
    fi

    # 4.2 Create a filename based on the project ID
    REPORT_FILENAME="$REPORT_DIR/${PROJECT_ID}_owners.txt"

    echo "Saving results to $REPORT_FILENAME..."
    echo "-----------------------------------------------"
    echo

    # 4.3 Use a Block Redirect to write all output to the file at once
    {
        echo "IAM Owner Report for project: $PROJECT_ID"
        echo "Time of extraction: ${TIMESTAMP}"
        echo "-----------------------------------------------"
        echo "Members found with the '$ROLE_TO_FIND' role (Google Service Agents excluded):"
        echo "$OWNER_MEMBERS"
        echo
        echo "-----------------------------------------------"
    } > "$REPORT_FILENAME"
    
    echo "Results succesfully saved to $REPORT_FILENAME."
    echo

    # 4.4 Store raw data as CSV
    REPORT_CSV_FILENAME="$REPORT_DIR/${PROJECT_ID}_raw_data.csv"
    echo "Saving raw data to $REPORT_CSV_FILENAME..."
    echo "-----------------------------------------------"
    echo

    # 4.4.1 Write raw data to CSV file
    {
        echo "Member_Indentifier"
        echo "$OWNER_MEMBERS"
    } > "$REPORT_CSV_FILENAME"

    echo "Raw data succesfully saved to $REPORT_CSV_FILENAME."
    echo

else
    echo "Results NOT saved to a file. Finished."
fi
