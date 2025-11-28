# gcloud-owner (v1.1.0)

Automate the process of managing GCP. In this version (v1.1.0) you can store the owners of GCP-projects in dedicated files!

## How to use

1. Download [gc-owner.sh](./gc-owner.sh) and make it executable with ```chmod +x gc-owner.sh``` in your terminal in the same directory as the file.
2. Ensure that Google Cloud CLI is installed and authentizised with ```gcloud auth login --update-adc```.
3. Execute the script with ```./gc-owner.sh <YOUR-GCP-PROJECT-ID>```.
4. All the owners that are not inherited should now be listed in your terminal similiar to something like this:

```sh
Setting project to: <YOUR-GCP-PROJECT-ID>
Searching for members with the 'roles/owner' role in project '<YOUR-GCP-PROJECT-ID>'...
--------------------------------------------------------
user:alice.example@domain.com
user:bob.example@domain.com
--------------------------------------------------------
```

5. If you want to store this information in a dedicated file ```<YOUR-GCP-PROJECT-ID>_owners.txt``` answer "yes" or "y" when asked and the file will be created in the same directory as where you run this script.

```sh
Do you want to save the results to a file? (y/n): yes
```

or

```sh
Do you want to save the results to a file? (y/n): y
```

*If you don't want to save it in a file simply answer anything but "yes" or "y".*

### Requiremenets

To use this script you need to have the correct permissions to use the script. The permissions that you currently need is:

- ```roles/resourcemanager.projectIamAdmin```- Your user account has the permission to use ```gcloud projects get-iam-policy```.

## Version history

Here is a table of all the versions published so far...

| Version | Published | Comment |
| ------- | --------- | ------- |
| v1.0.0 | 28th november 2025 | The first version. Checks for the owners and prints them in the terminal. |
| v1.1.0 | TBA | Will allow the user to get the information in a dedicated file. |
| v1.1.X | TBA | TBA |

## Upcoming updates

- Store the owners in dedicated files.
- Even more automation features!

> Last updated: Friday 28 november 15:45
