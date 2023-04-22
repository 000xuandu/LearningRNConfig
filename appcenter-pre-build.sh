#!/usr/bin/env bash
printf "unpack secrets with password is $PASSWORD_SECRETS"
yarn unpack-secrets -p $PASSWORD_SECRETS
