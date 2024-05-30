#!/bin/bash
rm -rf ./organizations/peerOrganizations || true
rm -rf ./organizations/ordererOrganizations || true
rm -rf ./organizations/fabric-ca/org1 || true
rm -rf ./organizations/fabric-ca/org2 || true
rm -rf ./organizations/fabric-ca/ordererOrg || true
rm -rf ./channel-artifacts || true
rm -rf ./logs || true


## VM1
# peer0
rm -rf /home/vm1/hlf-test-multi-org/peer0org1/production
rm -rf /home/vm1/hlf-test-multi-org/org1/peer0/data/snapshots
rm -rf /home/vm1/hlf-test-multi-org/peer0org1
rm -rf /home/vm1/hlf-test-multi-org/org1
rm -rf /home/vm1/hlf-test-multi-org/production
# peer1
rm -rf /home/vm1/hlf-test-multi-org/peer1org1/production
rm -rf /home/vm1/hlf-test-multi-org/org1/peer1/data/snapshots
rm -rf /home/vm1/hlf-test-multi-org/peer1org1
rm -rf /home/vm1/hlf-test-multi-org/org1
rm -rf /home/vm1/hlf-test-multi-org/production


## VM2
# peer0
rm -rf /home/vm2/hlf-test-multi-org/peer0org1/production
rm -rf /home/vm2/hlf-test-multi-org/org1/peer0/data/snapshots
rm -rf /home/vm2/hlf-test-multi-org/peer0org1
rm -rf /home/vm2/hlf-test-multi-org/org1
rm -rf /home/vm2/hlf-test-multi-org/production
# peer1
rm -rf /home/vm2/hlf-test-multi-org/peer1org1/production
rm -rf /home/vm2/hlf-test-multi-org/org1/peer1/data/snapshots
rm -rf /home/vm2/hlf-test-multi-org/peer1org1
rm -rf /home/vm2/hlf-test-multi-org/org1
rm -rf /home/vm2/hlf-test-multi-org/production


## VM3
# peer0
rm -rf /home/vm3/hlf-test-multi-org/peer0org1/production
rm -rf /home/vm3/hlf-test-multi-org/org1/peer0/data/snapshots
rm -rf /home/vm3/hlf-test-multi-org/peer0org1
rm -rf /home/vm3/hlf-test-multi-org/org1
rm -rf /home/vm3/hlf-test-multi-org/production
# peer1
rm -rf /home/vm3/hlf-test-multi-org/peer1org1/production
rm -rf /home/vm3/hlf-test-multi-org/org1/peer1/data/snapshots
rm -rf /home/vm3/hlf-test-multi-org/peer1org1
rm -rf /home/vm3/hlf-test-multi-org/org1
rm -rf /home/vm3/hlf-test-multi-org/production


## VM1 channel artifacts
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/config_block.json
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/config_block.pb
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/config_update_in_envelope.json
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/config_update.json
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/config_update.pb
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/log.txt
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/modified_config.pb
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/Org1MSPanchors.tx
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/Org1MSPconfig.json
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/Org1MSPmodified_config.json
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/original_config.pb


## VM2 channel artifacts
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/config_block.json
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/config_block.pb
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/config_update_in_envelope.json
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/config_update.json
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/config_update.pb
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/log.txt
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/modified_config.pb
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/Org1MSPanchors.tx
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/Org1MSPconfig.json
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/Org1MSPmodified_config.json
rm -rf /home/vm2/hlf-test-multi-org/distributed-machine-org1/original_config.pb


## VM3 channel artifacts
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/config_block.json
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/config_block.pb
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/config_update_in_envelope.json
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/config_update.json
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/config_update.pb
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/log.txt
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/modified_config.pb
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/Org1MSPanchors.tx
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/Org1MSPconfig.json
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/Org1MSPmodified_config.json
rm -rf /home/vm3/hlf-test-multi-org/distributed-machine-org1/original_config.pb

#remove chaincode added files
rm -rf /home/vm1/hlf-test-multi-org/distributed-machine-org1/testreportcc.tar.gz