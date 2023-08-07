#!/bin/bash

echo "USE AT YOUR OWN RISK"
read -p "Are you sure? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

eth2-val-tools keystores \
  --source-min=$ACC_START_INDEX \
  --source-max=$ACC_END_INDEX \
  --source-mnemonic="$WITHDRAWALS_MNEMONIC" \
  --out-loc=$KEYSTORE_WITHDRAW \
  --prysm-pass=$KEYSTORE_PASSWORD

# Flags:
#   -h, --help                     help for keystores
#       --insecure                 Enable to output insecure keystores (faster generation, ONLY for ephemeral private testnets
#       --out-loc string           Path of the output data for the host, where wallets, keys, secrets dir, etc. are written (default "assigned_data")
#       --prysm-pass string        Password for all-accounts keystore file (Prysm only)
#       --source-max uint          Maximum validator index in HD path range (excl.)
#       --source-min uint          Minimum validator index in HD path range (incl.)
#       --source-mnemonic string   The validators mnemonic to source account keys from.
