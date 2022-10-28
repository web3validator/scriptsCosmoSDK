#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
WITHOU_COLOR='\033[0m'
DELEGATOR_ADDRESS='tori1........address'
VALIDATOR_ADDRESS='torivaloper1.....address'
PWD='yourCliPassword'
DELAY=7200 #in secs - how often restart the script
ACC_NAME='account name' #example: = ACC_NAME=wallet_qwwq_54
NODE=https://teritori.nodejumper.io:443 #change it only if you use another rpc 

for (( ;; )); do
        echo -e "Claim rewards\n"
        echo -e "${PWD}\n${PWD}\n" | teritorid tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --chain-id teritori-1 --from ${ACC_NAME} --node ${NODE} --commission -y --gas-prices 0.01utori --gas 600000
        for (( timer=4; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 4
        done
        BAL=$(teritorid query bank balances ${DELEGATOR_ADDRESS} --node ${NODE} -o json | jq -r '.balances | .[].amount');
        BAL=$(echo "$BAL - 100000"|bc)
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} utori\n"
        echo -e "Stake ALL \n"
        echo -e "${PWD}\n${PWD}\n" | teritorid tx staking delegate ${VALIDATOR_ADDRESS} ${BAL}utori --chain-id teritori-1 --from ${ACC_NAME} --node ${NODE} -y --gas-prices 0.01utori --gas 600000
        for (( timer=${DELAY}; timer>3; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done

done
