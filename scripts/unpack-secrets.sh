########################################################################################
# Unzip secrets archive, copying the secret files to the correct locations in the repo #
# Command: ./scripts/unpack-secrets.sh -e <environment> -p <password>                  #
########################################################################################

#! /bin/bash

set -e
read -sp "Please enter the password: " SECRETS_PASSPHRASE

# Select encrypted file
FILE_ROOT="secrets.tar.gz"

## Decrypt
gpg --decrypt --passphrase $SECRETS_PASSPHRASE --batch "./__secrets__/$FILE_ROOT.gpg" > "./__secrets__/$FILE_ROOT.tar.gz"

## Unzip to correct locations in project
tar -xzvf "./__secrets__/$FILE_ROOT.tar.gz"

## Remove intermediaries
rm "./__secrets__/$FILE_ROOT.tar.gz"

echo -e "✅ Secrets have been unpacked to the correct location in your local environment"
