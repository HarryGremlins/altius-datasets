mkdir -p transfer/many-to-one

for tx in 10 100 1000 10000; do
    if [ $tx -eq 1000 ]; then
        tn="1k"
    elif [ $tx -eq 10000 ]; then
        tn="10k"
    else
        tn=$tx
    fi

    if [ $tx -ne 10 ]; then
        for groupsize in 20 5 2; do
            group=$((tx / groupsize))

            # many-to-one
            ../altius-benchtools/target/release/generate pattern -y m2o \
                -t $tx -g $group -o ./transfer/many-to-one/m2o-t${tn}-g${group}.json
            ../altius-benchtools/target/release/generate pattern -y m2o \
                -t $tx -g $group -o ./transfer/many-to-one/m2o-erc20-t${tn}-g${group}.json --erc20
            
        done
    fi
done
