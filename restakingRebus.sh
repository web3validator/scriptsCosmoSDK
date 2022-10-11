#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
WITHOU_COLOR='\033[0m'
DELEGATOR_ADDRESS='rebus1....address'
VALIDATOR_ADDRESS='rebusvaloper....adress'
PWD=YourPassword'
DELAY=7200 #in secs - how often restart the script 
ACC_NAME='web34ever' #example: = ACC_NAME=wallet
NODE=http://localhost:33657 #change it only if you use another rpc port of your node

for (( ;; )); do
        echo -e "Claim rewards\n"
        echo -e "${PWD}\n${PWD}\n" | rebusd tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --chain-id reb_1111-1 --from ${ACC_NAME} --node ${NODE} --commission -y --fees 10000arebus
        for (( timer=4; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done
        BAL=$(rebusd query bank balances ${DELEGATOR_ADDRESS} --node ${NODE} -o json | jq -r '.balances | .[].amount');
        BAL=$(echo "$BAL - 100000000"|bc)
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} arebus\n"
        echo -e "Stake ALL \n"
        echo -e "${PWD}\n${PWD}\n" | rebusd tx staking delegate ${VALIDATOR_ADDRESS} ${BAL}arebus --chain-id reb_1111-1 --from ${ACC_NAME} --node ${NODE} -y --gas-prices 0.01arebus --gas 3000000
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done

done
