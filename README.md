
# Aerie Validator management tools

  

__*Warning: Use at your own RISK, this is all very EXPERIMENTAL*__

  
## Dependencies
1. Go language installed, we use Go 1.19, do not use below this version
2. CL & EL Node running properly, visit [here](https://github.com/aerielabio/public-node) for more details

## Deposits

  

Optionally install [`ethereal`](https://github.com/wealdtech/ethereal/), to run the `exec_deposits.sh` step.

  

Important: when installing, run the commands outside of the root directory of this repository, to not mix up the go modules.

  

```shell script

# Install this assignments tool

go  build -o aerie-val-tools 

  

# Move out of this dir

cd  ..

  

# Install ethereal

GO111MODULE=on  go  install  github.com/wealdtech/ethereal@latest

```

  

Pre-Deposit Preparation Steps:
1. Create New Mnemonic by executing `aerie-val-tools mnemonic` twice: one for validator keys, one for withdrawal keys. Put them in the config.
2. Copy `example_config.sh` into something else, for example `config.sh` , and paste mnemonic generated above within this file.
3. Change `ETH1_FROM_ADDR` into some address that you will use it later for withdrawal and sending the deposit from.
4. Change `ETH1_FROM_PRIV` into the private key of the address above.
5. We recommend to create a completely new address for point 3 & 4
6.  Run this command `chmod +x *.sh && source ./config.sh`
7. Run `echo $ETH1_FROM_ADDR` , and make sure it outputting a same address with what you fill into the `config.sh` file
8. Execute ./build_deposits.sh
9. You will get a new file, `deposit_datas.txt` , do not remove this file, you can just leave it as it is

Now after you finished the preparation, you will proceed into the deposit step.  Make sure that the address on point 3 above holds the required amount for the validators that you want to make. **1 Validator will need 1,000,000 AER for deposit**, so as an example, if you generate **24 validators** ( by put ACC_START_INDEX=0 and ACC_END_INDEX=24 ) for example, then you will need 24,000,000 AER within that wallet. Make sure you have some spare for the Gas of the execution 

Now, lets proceed.
1. Execute `./exec_deposits.sh` , make sure you did execute `source ./config.sh` before
2. Wait until all the deposit finished ( You will need to wait at least 10 Block until your deposit will be observed by the beacon after the deposit finished )
3. Execute `./validator_keystores.sh`  to generate the keystores that later will be imported into prysm validator
4. After you execute point 3, you will see new folder named **validators_keystore** , visit that folder and you will see some folders there
5. Visit prysm folder inside this folder, and you will see **keymanageropts.json** file and **direct** folder. Copy this file , and copy into the wallet-dir of your validator. If you refer into our repo [here](https://github.com/aerielabio/validator-node) , you will need to paste it into misc > wallet-dir


  

## Commands

  

### `keystores`

  

Builds keystores/secrets in every format, for a given mnemonic and account range.

  

```

Usage:

aerie-val-tools keystores [flags]

  

Flags:

-h, --help help for keystores


--out-loc string Path of the output data for the host, where wallets, keys, secrets dir, etc. are written (default "assigned_data")

--prysm-pass string Password for all-accounts keystore file (Prysm only)

--source-max uint Maximum validator index in HD path range (excl.)

--source-min uint Minimum validator index in HD path range (incl.)

--source-mnemonic string The validators mnemonic to source account keys from.

  

```

  

### `mnemonic`

  

Outputs a bare 256 bit entropy BIP39 mnemonic, or stops with exit code 1.

  

```

Create a random mnemonic

  

Usage:

aerie-val-tools mnemonic [flags]

  

Flags:

-h, --help help for mnemonic

```

  

### `deposit-data`

  

To quickly generate a list of deposit datas for a range of accounts.

  

```

Create deposit data for the given range of validators. 1 json-encoded deposit data per line.

  

Usage:

aerie-val-tools deposit-data [flags]

  

Flags:

--amount uint Amount to deposit, in Gwei (default 32000000000)

--fork-version string Fork version, e.g. 0x20000000

-h, --help help for deposit-data

--source-max uint Maximum validator index in HD path range (excl.)

--source-min uint Minimum validator index in HD path range (incl.)

--validators-mnemonic string Mnemonic to use for validators.

--withdrawals-mnemonic string Mnemonic to use for withdrawals. Withdrawal accounts are assumed to have matching paths with validators.

```

  

### `pubkeys`

  

List pubkeys of the given range of validators. Output encoded as one pubkey per line.

  

Example, list pubkeys (for a random new mnemonic), account range `[42, 123)`:

```shell script

aerie-val-tools  pubkeys  --validators-mnemonic="$(aerie-val-tools mnemonic)"  --source-min=42  --source-max=123

```

  

## Output

  

Beacon clients structure their validators differently, but this tool outputs all the required data for each of them.

  

### Prysm

  

Prysm is a special case, they are centric around the Ethdo wallet system. Instead of using the EIP 2335 key files directly, like all the other clients.

  

In the output directory, a `prysm` dir is placed, with the following contents:

  

-  `keymanager_opts.json`: JSON file describing accounts and their passphrases. And the "Location" part can be configured with `--key-man-loc`,

which will point to some "wallets" directory: where the actual wallets can be found.

- Prysm requires Account names listed in the JSON to be prefixied with the wallet name, separated by a `/`. Like `Assigned/foobarvalidator`.

- Ethdo wallets are in the same big store, and only one directory in this store per wallet. The directory must be named as UUID, and in the directory there must be a file with the same UUID name to describe the wallet.

- Ethdo key files in the wallet must also be named as a UUID, so that they can be parsed in the `.Accounts()` call

-  `wallets`: a directory which is an Ethdo store with a single non-deterministic wallet in it, covering all keys.

- The wallet name is called `Assigned`, and the keys are `Assigned/val_<pubkey here>` (excluding `<` and `>`) The pubkey is hex encoded, without `0x`.

- The wallet also contains an `index` file and all other ethdo-specific things

## License

  

MIT, see [`LICENSE`](./LICENSE) file.