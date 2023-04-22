########################################################################################
# Unzip secrets archive, copying the secret files to the correct locations in the repo #
# Command: ./scripts/unpack-secrets.sh -e <environment> -p <password>                  #
########################################################################################

#! /bin/bash

set -e
SECRETS_PASSPHRASE=""

while getopts ":p:" opt; do
  case $opt in
    p) SECRETS_PASSPHRASE="$OPTARG"
    ;;
    \?) echo "${RED}Invalid option -$OPTARG${NO_COLOR}" >&2
    ;;
  esac
done

if [[ $SECRETS_PASSPHRASE == "" ]]; then
    read -sp "Please enter the password: " SECRETS_PASSPHRASE
fi

# Select encrypted file
FILE_ROOT="secrets.tar.gz"

## Decrypt
gpg --decrypt --passphrase $SECRETS_PASSPHRASE --batch "./__secrets__/$FILE_ROOT.gpg" > "./__secrets__/$FILE_ROOT.tar.gz"

## Unzip to correct locations in project
tar -xzvf "./__secrets__/$FILE_ROOT.tar.gz"

## Remove intermediaries
rm "./__secrets__/$FILE_ROOT.tar.gz"

echo -e "✅ Secrets have been unpacked to the correct location in your local environment"
