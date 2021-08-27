# Perfectly Balanced ⚖️

![image](https://user-images.githubusercontent.com/88283485/130841235-3e8901c5-3477-4107-b15f-f284a06a9665.png)

Script to make your LND node pefectly balanced as all things should be.
Inspired by [Igniter](https://github.com/RooSoft/igniter), [Rebalance-LND](https://github.com/C-Otto/rebalance-lnd) and [Balance Of Satoshi](https://github.com/alexbosworth/balanceofsatoshis)

## Requirements:

Almost all included by default in most linux distros:

- `bash`
- `python3`
- `bc`
- `wget`
- `unzip`

Make sure your LND path is located or linked to `$HOME/.lnd`

## Usage

Not need to edit anything, just run it! 🚀

```
Usage: ./perfectlybalanced.sh {-v|-h|-m=VALUE|-t=VALUE|list|rebalance}

Optional:
        -v, --version
                Shows the version for this script

        -h, --help
                Shows this help

        -i=CHANNEL_ID, --ignore=CHANNEL_ID
                Ignores a specific channel id useful only if passed before 'list' or 'rebalance'
                It can be used many times and should match a number of 18 digits

        -m=MAX_FEE, --max-fee=MAX_FEE
                (Default: 100) Changes max fees useful only if passed before 'list' or 'rebalance'

        -t=TOLERANCE, --tolerance=TOLERANCE
                (Default: 0.98) Changes tolerance useful only if passed before 'rebalance'

list:
        Shows a list of all channels in compacted mode using 'rebalance.py -c -l'
        for example to: './perfectlybalanced.sh --tolerance=0.99 list'

rebalance:
        Tries to rebalance unbalanced channels with default max fee of 100 and tolerance 0.98
        for example to: './perfectlybalanced.sh --max-fee=10 --tolerance=0.95 rebalance'
```

## Examples

List all channels within tolerance 0.92:

`./perfectlybalanced.sh --tolerance=0.92 list`

or

`./perfectlybalanced.sh -t=0.92 list`

Default list within tolerance 0.98:

`./perfectlybalanced.sh list`

Unbalanced channels being rebalanced max fee 10 sats and tolerance 0.97:

`./perfectlybalanced.sh --max-fee=10 --tolerance=0.97 rebalance`

or

`./perfectlybalanced.sh -m=10 -t=0.97 rebalance`


Default max fee 100 sats and tolerance 0.98:

`./perfectlybalanced.sh rebalance`

Rebalance with max fee 10 sats and tolerance 0.98, ignoring channel id '761128128258703361':

`./perfectlybalanced.sh --ignore=761128128258703361 -t=0.98 -m=10 rebalance`

![image](https://user-images.githubusercontent.com/88283485/131143050-ed227d2c-40ae-478a-91b1-0c4f95743bb1.png)

## Contribute

Feel free to collaborate with code or donate a few Satoshi using your LND Lightning node ⚡ 😄

`lncli sendpayment --keysend 03e7299ced214b19b87ed87979462d9aee3ec07a42fe6e2211854bfa4cb32b0bb8 100 # sats`
