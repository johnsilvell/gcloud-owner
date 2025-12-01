# gcloud-owner (v1.1.1)

Automate the process of managing GCP. From version 1.1.0 you can store the owners of GCP-projects in dedicated files!

## Quick links

- [Manual](https://github.com/johnsilvell/gcloud-owner?tab=readme-ov-file#how-to-use)
    - [Requirements](https://github.com/johnsilvell/gcloud-owner?tab=readme-ov-file#how-to-use)
- [Debugging](https://github.com/johnsilvell/gcloud-owner?tab=readme-ov-file#debugging)
- [Version history](https://github.com/johnsilvell/gcloud-owner?tab=readme-ov-file#requiremenets)
- [Updates](https://github.com/johnsilvell/gcloud-owner?tab=readme-ov-file#upcoming-updates)

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

You can find examples of these .txt-files in the directory "[examples](./examples)".

### Requiremenets

To use this script you need to have the correct permissions to use the script. The permissions that you currently need is:

- ```roles/resourcemanager.projectIamAdmin```- Your user account has the permission to use ```gcloud projects get-iam-policy```.

## Debugging

The script will of course always be tested during development but for extra security this repo uses GitHub Actions for CI/CD-integration. However, due to security vulnerabilities we currently only do lint-testing in its current state since we don't want to have our Google Cloud credidentials uploaded on GitHub.

If you would like to review or analyze our current GitHub Actions-setup please check [.github/workflows](./.github/workflows).

## Version history

Here is a table of all the versions published so far...

| Version | Published | Comment |
| ------- | --------- | ------- |
| v1.0.0 | 28th november 2025 | The first version. Checks for the owners and prints them in the terminal. |
| v1.1.0 | 1st december 2025 | Will allow the user to get the information in a dedicated txt-file. |
| v1.1.1 | 1st december 2025 | Added a filter to remove potential "Service Agents" from the search results. General stability improvements. |
| v1.1.2 | TBA | Store the information for future export to a database. |

## Upcoming updates

- Even more automation features!

> Last updated: Monday 01 december 15:20
