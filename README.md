# Babylon node - latest version from the official doc

## How to run the node
### Script babylon-node-1.sh
Run that script as follow :
``./babylon-node-1.sh NODENAME``
where NODENAME is the name you want to give to the node

### Script babylon-node-2.sh
Before executing that script, update the following files :
#### ~/.babylond/config/config.toml
Edit the configuration file at ~/.babylond/config/config.toml and modify the seeds and persistent_peers attributes to contain appropriate seeds and peers of your choice. Set them as follow :
``
# Comma separated list of seed nodes to connect to
seeds = "8da45f9ff83b4f8dd45bbcb4f850999637fbfe3b@seed0.testnet.babylonchain.io:26656,4b1f8a774220ba1073a4e9f4881de218b8a49c99@seed1.testnet.babylonchain.io:26656"

# Comma separated list of nodes to keep persistent connections to
persistent_peers = "https://rpc.testnet.babylonchain.io:443,https://node-api.testnet.babylonchain.io:443"
``

#### ~/.babylond/config/app.toml
Edit the configuration file at ~/.babylond/config/app.toml and modify the btc-network attribute to contain the appropriate BTC network parameters as below.

``
[btc-config]
network = "mainnet"
``
I think this step is already done in the latest version of the official doc but it is mandatory to check it.

On the same file, you can also modify the minimum-gas-prices attribute and set it to a value of your choosing. For example,
``
minimum-gas-prices = "0.00001ubbn"
``
