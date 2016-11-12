#/bin/bash

geth  --identity "PhuaChuKang" \
      --rpc \
      --rpcport "8080" \
      --rpccorsdomain "*" \
      --datadir "./blockchain_data" \
      --port "30303" \
      --nodiscover \
      --rpcapi "db,eth,net,web3" \
      --networkid 1999 \
      $@ && rm -rf ~/.ethash
