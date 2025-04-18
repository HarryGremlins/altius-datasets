mkdir -p transfer
mkdir -p transfer/many-to-many
mkdir -p transfer/one-to-many
mkdir -p transfer/chained
mkdir -p transfer/self-to-self

for tx in 10 100 1000 10000; do
    if [ $tx -eq 1000 ]; then
        tn="1k"
    elif [ $tx -eq 10000 ]; then
        tn="10k"
    else
        tn=$tx
    fi
    
    # many-to-many
    for conflict in 0 0.1 0.2 0.5 0.8; do
        cn=$(echo "$conflict * 100" | bc | cut -d. -f1)
        ../altius-benchtools/target/release/generate pattern -y m2m \
            -t $tx -c $conflict -o ./transfer/many-to-many/m2m-t${tn}-c${cn}.json
        ../altius-benchtools/target/release/generate pattern -y m2m \
            -t $tx -c $conflict -o ./transfer/many-to-many/m2m-erc20-t${tn}-c${cn}.json --erc20
    done

    if [ $tx -ne 10 ]; then
        for groupsize in 20 5 2; do
            group=$((tx / groupsize))

            # one-to-many
            ../altius-benchtools/target/release/generate pattern -y o2m \
                -t $tx -g $group -o ./transfer/one-to-many/o2m-t${tn}-g${group}.json
            ../altius-benchtools/target/release/generate pattern -y o2m \
                -t $tx -g $group -o ./transfer/one-to-many/o2m-erc20-t${tn}-g${group}.json --erc20

            # chained
            ../altius-benchtools/target/release/generate pattern -y chained \
                -t $tx -g $group -o ./transfer/chained/chain-t${tn}-g${group}.json
            ../altius-benchtools/target/release/generate pattern -y chained \
                -t $tx -g $group -o ./transfer/chained/chain-erc20-t${tn}-g${group}.json --erc20
            
        done
    fi

    # self-to-self
    ../altius-benchtools/target/release/generate pattern -y s2s \
        -t $tx -o ./transfer/self-to-self/s2s-t${tn}.json
    ../altius-benchtools/target/release/generate pattern -y s2s \
        -t $tx -o ./transfer/self-to-self/s2s-erc20-t${tn}.json --erc20
done
