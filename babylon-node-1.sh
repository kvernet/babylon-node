#!/usr/bin/env bash

NODENAME=${1:-"babylon-node-kvcrypto2022"}

# update
sudo apt update -y

# install prerequisites
sudo apt install wget git build-essential curl jq --yes

# install go
wget https://go.dev/dl/go1.21.5.linux-amd64.tar.gz
rm -rf go
tar -xzf go1.21.5.linux-amd64.tar.gz
rm go1.21.5.linux-amd64.tar.gz
export PATH=$(pwd)/go/bin:$PATH
go version

# install babylon
if [ -d babylon ]; then
    rm -rf babylon
fi
git clone https://github.com/babylonchain/babylon.git
cd babylon
make build && cd ..
export PATH=$(pwd)/babylon/build:$PATH
babylond version

# init the node directory
if [ -d ~/.babylond ]; then
    rm -rf ~/.babylond
fi
mkdir -p ~/.babylond
babylond init $NODENAME --chain-id bbn-test-2
wget https://github.com/babylonchain/networks/raw/main/bbn-test-2/genesis.tar.bz2
tar -xjf genesis.tar.bz2 && rm genesis.tar.bz2
mv genesis.json ~/.babylond/config/genesis.json
