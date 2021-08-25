#!/bin/bash

# Perfectly Balanced as all things should be
# By Cuaritas 2021
# MIT License

# Your channels to keep perfectly balanced, get them with `rebalance.py -l -c`
# See https://github.com/C-Otto/rebalance-lnd for more info
REBALANCE_LND_FILEPATH=/home/umbrel/Downloads/rebalance-lnd/rebalance.py
LND_DIR=/mnt/umbrel/Umbrel/lnd/
MAX_FEE=100
TOLERANCE=0.999 # I do not recommend to put 1 here, it may get crazy XD

declare -a channels=(
  766511337228992513 # SpaintoLATAM
  766880773108203521 # renoblitz
  766283738386399232 # 02a446876eafbbdaa96e
  765011603400949760 # Gondolin
  765016001414299649 # rbvdr21
  766262847645417473 # 031b0b9df8e34e53de02
  766874176095649792 # LibertyBull
  766898365405003777 # Plaidfunds
  761111635631734784 # 02c603d30ea3711144d4
  766534426924810241 # Cuerna
)

# Liquidity channels also included in `reb -l -c` but you use these channels to pump and dump sats

LIQUIDITY_PUMP=766237558887612417 # LNBIG.com [lnd-03]
LIQUIDITY_DUMP=761128128258703361 # LNBIG.com [lnd-13]

# Script logic, stop editing right here, it gets reckless!!! hehehe

cat << PERFECT
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓
▒▒▒▒▒▒▒Perfectly balanced, as all things should be...▒▒▒▒░░░▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓████▓
▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓█▓███▓
▒▒▒▒▒▒▒▒▒▒▓▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▓▓██▓▒▓▓▓▓▓▓▓▓▓▓▓███▓██▓▓▓▓▓▓▓▓▓▓█▓███▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▓██▓▒▓▓▓▓▓▓▓▓▓█████▓██▓▓▓▓▓▓▓▓▓▓█▓██▓▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓███▒▓▓▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓█▓██▓▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▓▓███▓▒▓▓▓▓▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓▓██████▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▓▓███▓▓▓▓▓▓▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓▓███████
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓█▓▓▓▓▓▓▒▒▒░░▒▒▓▓▓▓▓████▓▓▓▓▓▓▓▓▓▓▓▓██████▓▓▓▓▓▓▓▓▓▓▓███████
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓███▓████▓▓█▓▓▓▓▒▓▓████▓▓▓███▓█▓▓█████████▓▓▓▓▓▓▓▓▓▓███████▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓████████▓▓▒▒▓▒▓▓▓▓▒▒▒▓███▓███████████▓▓▓▓▓▓▓▓▓██████▓▓▓
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▒▓▓▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓█▓▓▓▓▓▓▓▓▓▓███████
▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓████████████
▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓█████▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓█▓▒▓▓▓███▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓█▓█▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓██▓▓▒▒▒▒▒▒▒▒▒
PERFECT


reb () {
  python3 $REBALANCE_LND_FILEPATH --lnddir=$LND_DIR $@
}

UNBALANCED=()
list () {
  echo -e "\nChecking these channels, red are outside tolerence $TOLERANCE and green are ok:\n"

  inbound=0
  outbound=0

  for c in ${channels[@]}; do
    temp=`reb -l -c | grep $c`
    inbound=`echo $temp | awk '{ printf $3 }' | sed 's/,//g'`
    outbound=`echo $temp | awk '{ printf $5 }' | sed 's/,//g'`
    if [[ `bc -l <<< "$inbound/$outbound >= $TOLERANCE && $outbound/$inbound >= $TOLERANCE"` -eq 1 ]]; then
     export GREP_COLORS='ms=01;32'
    else
     export GREP_COLORS='ms=01;31'
     UNBALANCED+=("$c")
    fi
    reb -l -c | grep --color=always $c
  done

  echo -e "\nLiquidity PUMP (uses outbound cap) and DUMP (uses inbound cap) to get other channels perfectly balanced:\n"
  export GREP_COLORS='ms=01;34'
  reb -l -c | grep --color=always $LIQUIDITY_PUMP
  reb -l -c | grep --color=always $LIQUIDITY_DUMP
}

rebalance () {
  if [[ ${#UNBALANCED[@]} -eq 0 ]]; then
    echo -e "\nAll Channels are balanced according to tolerance levels $TOLERANCE\n"
    exit
  else
    echo -e "\nTrying to rebalance these unbalanced channels:\n"
    export GREP_COLORS='ms=01;31'
    for u in ${UNBALANCED[@]}; do
      reb -l -c | grep --color=always $u
    done
  fi
  echo
  for u2 in ${UNBALANCED[@]}; do
    amount=`reb -l --show-only $u2 | grep "Rebalance amount:" | awk '{ printf $3 }' | sed 's/,//g'`
    echo $amount | grep -q "-"
    if [[ $? -eq 0 ]]; then
      reb -f $u2 -t $LIQUIDITY_DUMP --amount ${amount#-} --reckless --min-local 0 --min-amount 0 --fee-limit $MAX_FEE --min-remote 0
    else
      reb -f $LIQUIDITY_PUMP -t $u2 --amount $amount --reckless --min-local 0 --min-amount 0 --fee-limit $MAX_FEE --min-remote 0
    fi
  done
}

VERSION=0.0.1

case "$1" in
--version)
  echo "$0 v${VERSION}"
  ;;
--help)
  echo "Usage: $0 {--version|--help|list|rebalance}"
  ;;
list)
  list
  ;;
rebalance)
  list
  rebalance
  list
  ;;
*)
  echo "Try --help"
  ;;
esac
