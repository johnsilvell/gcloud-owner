# gcloud-owner (v1.0.0)

Automate the process of managing GCP. This is the first official version (version 1.0.0)!

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

## Upcoming updates

- Store the owners in dedicated files.
- Even more automation features!

> Last updated: Friday 28 november 10:20 a.m.
