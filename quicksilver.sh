#!/bin/bash
GREEN_COLOR='\033[0;32m'
RED_COLOR='\033[0;31m'
WITHOU_COLOR='\033[0m'
DELEGATOR_ADDRESS='YOUR_quicksilver......ADDRESS'
VALIDATOR_ADDRESS='YOUR_quicksilvervaloper1ADDRESS'
PWD='YOUR_PASSWORD'
DELAY=3200 #in secs - how often restart the script 
ACC_NAME='YOU_WALLET_WITHOUT_QUOTES' #example: = ACC_NAME=wallet_qwwq_54
NODE=http://localhost:26657 #change it only if you use another rpc port of your node

for (( ;; )); do
        echo -e "Get reward from Delegation"
        echo -e "${PWD}\ny\n" | quicksilverd tx distribution withdraw-all-rewards --from ${ACC_NAME} --fees 200uqck --chain-id quicktest-3 --yes
        for (( timer=10; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOUT_COLOR} sec\r" $timer
                sleep 1
        done

        BAL=$(quicksilverd query bank balances ${DELEGATOR_ADDRESS} --node ${NODE});
        # BAL=$(($BAL -100000))
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} uqck\n"
        echo -e "Claim rewards\n"
        echo -e "${PWD}\n${PWD}\n" | quicksilverd tx distribution withdraw-rewards ${VALIDATOR_ADDRESS} --chain-id quicktest-3 --from ${ACC_NAME} --node ${NODE} --commission -y --fees 1000uqck
        for (( timer=10; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done
        BAL=$(quicksilverd query bank balances ${DELEGATOR_ADDRESS} --node ${NODE} -o json | jq -r '.balances | .[].amount');
        BAL=$(($BAL -100000))
        echo -e "BALANCE: ${GREEN_COLOR}${BAL}${WITHOU_COLOR} uqck\n"
        echo -e "Stake ALL 11111\n"
        echo -e "${PWD}\n${PWD}\n" | quicksilverd tx staking delegate ${VALIDATOR_ADDRESS} ${BAL}uqck --chain-id quicktest-3 --from ${ACC_NAME} --node ${NODE} -y --fees 1000uqck
        for (( timer=${DELAY}; timer>0; timer-- ))
        do
                printf "* sleep for ${RED_COLOR}%02d${WITHOU_COLOR} sec\r" $timer
                sleep 1
        done       

done
