#!/usr/bin/env bash

export PATH=$(pwd)/go/bin:$PATH
go version

export PATH=$(pwd)/babylon/build:$PATH
babylond version

export PATH=~/go/bin:$PATH


# setup cosmovisor
go install cosmossdk.io/tools/cosmovisor/cmd/cosmovisor@latest


mkdir -p ~/.babylond
mkdir -p ~/.babylond/cosmovisor
mkdir -p ~/.babylond/cosmovisor/genesis
mkdir -p ~/.babylond/cosmovisor/genesis/bin
mkdir -p ~/.babylond/cosmovisor/upgrades

cp $(pwd)/babylon/build/babylond ~/.babylond/cosmovisor/genesis/bin/babylond

# setup a cosmovisor service
sudo tee /etc/systemd/system/babylond.service > /dev/null <<EOF
[Unit]
Description=Babylon daemon
After=network-online.target

[Service]
User=$USER
ExecStart=$(which cosmovisor) run start --x-crisis-skip-assert-invariants
Restart=always
RestartSec=3
LimitNOFILE=infinity

Environment="DAEMON_NAME=babylond"
Environment="DAEMON_HOME=${HOME}/.babylond"
Environment="DAEMON_RESTART_AFTER_UPGRADE=true"
Environment="DAEMON_ALLOW_DOWNLOAD_BINARIES=false"

[Install]
WantedBy=multi-user.target
EOF

# start the node
sudo -S systemctl daemon-reload
sudo -S systemctl enable babylond
sudo -S systemctl start babylond

# check the status of the node by running
systemctl status babylond
