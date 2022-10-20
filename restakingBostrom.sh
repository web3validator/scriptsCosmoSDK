#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
WITHOU_COLOR='\033[0m'
DELEGATOR_ADDRESS='bostrom1...'
VALIDATOR_ADDRESS='bostromvaloper1....'
PWD='password'
DELAY=7200 #in secs - how often restart the script 
ACC_NAME='accountName' #example: = ACC_NAME=wallet
NODE=https://rpc.bostrom.cybernode.ai:443

for (( ;; )); do
        echo -e "Claim rewards\n"
        echo -e "${PWD}\n${PWD}\n" | cyber tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --chain-id bostrom --from ${ACC_NAME} --commission -y --node ${NODE} --gas-prices 0.01boot --gas 300000
        for (( timer=4; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done
        BAL=$(cyber query bank balances ${DELEGATOR_ADDRESS} --node ${NODE} -o json | jq -r '.balances[] | select(.denom | contains("boot")).amount');
        BAL=$(echo "$BAL - 100000000"|bc)
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} boot\n"
        echo -e "Stake ALL \n"
        echo -e "${PWD}\n${PWD}\n" | cyber tx staking delegate ${VALIDATOR_ADDRESS} ${BAL}boot --chain-id bostrom --from ${ACC_NAME} -y --node ${NODE} --gas-prices 0.01boot --gas 3000000
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done

done

