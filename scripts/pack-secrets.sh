########################################################################################
# Zip secrets archive, from the root of the project. Saves the location of the secrets #
# for later unzipping.                                                                 #
# Command: ./scripts/pack-secrets.sh -e <environment>                                  #
########################################################################################
#! /bin/sh
set -e 

## Use to create the secrets archive by grabbing all the secret files from your current codebase.
## Useful to add/remove secrets from the archive, after having unpacked currently comited archive with unpack_secrets.sh.

FILE_ROOT="__secrets__/secrets"

# Select files to put in the archive
SECRETS_TO_PACK="env .env codepush"

echo $FILE_ROOT.tar.gz $SECRETS_TO_PACK
# Create archive
tar -cvzf $FILE_ROOT.tar.gz $SECRETS_TO_PACK

# Encrypt archive
gpg --symmetric $FILE_ROOT.tar.gz

## Remove intermediaries
rm $FILE_ROOT.tar.gz

echo -e "✅ Secrets have been packed into ${FILE_ROOT}.tar.gz.gpg. Please commit this encrypted archive."
