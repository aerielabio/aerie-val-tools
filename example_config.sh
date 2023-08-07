#!/bin/bash

# Generate a random one with `eth2-val-tools mnemonic`
# These are BIP39 mnemonics
export VALIDATORS_MNEMONIC=""
export WITHDRAWALS_MNEMONIC=""

# LEAVE IT AS IT IS
export FORK_VERSION="0x20000000"

# Range of accounts to create, deposit, etc.
# Incl.
export ACC_START_INDEX=0
# Excl.
export ACC_END_INDEX=24
# If you put ACC_START_INDEX=0 and ACC_END_INDEX=24, it will create 24 validators

# TODO: Insert deposit contract address here
export DEPOSIT_CONTRACT_ADDRESS="0x0000009f683783a040d39a235cae7bab6142bc1a"
export DEPOSIT_DATAS_FILE="./deposit_datas.txt"

# What the deposit tx will send
# PLEASE LEAVE IT AS IT IS, OTHERWISE YOUR AERIE WILL BE STUCK IN THE BLACKHOLE
export DEPOSIT_ACTUAL_VALUE="1000000Ether"
# What the deposit data will include (in Gwei)
export DEPOSIT_AMOUNT="1000000000000000"

# DO NOT DO THIS IN MAINNET
# With testnets you can be lazy and directly use a Goerli Eth1 keypair
# *change these*
export ETH1_FROM_ADDR="0xaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
export ETH1_FROM_PRIV="0xbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb"

# The deposit contract of Altona is not recognized, so we're forcing deposits through anyway
# Required for testnets that are not recognized by ethdo
export FORCE_DEPOSIT=true

# Eth1 network ID as used by Ethdo
export ETH1_NETWORK=84886

# KEYSTORES
export KEYSTORE_VALIDATORS=./validators_keystore
export KEYSTORE_WITHDRAW=./wd_keystore
export KEYSTORE_PASSWORD="aerieisgreat"