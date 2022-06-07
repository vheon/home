# This script would be used to persist locally the password for encrypted files so that we're not always
# prompt to enter the keychain password at each run.
# It just calls the script for gathering data from the keychain.

set -x ANSIBLE_VAULT_PASSWORD (./vault-keychain-client)
