#!/bin/bash
rm -rf ./organizations/peerOrganizations || true
rm -rf ./organizations/ordererOrganizations || true
rm -rf ./organizations/fabric-ca/org1 || true
rm -rf ./organizations/fabric-ca/org2 || true
rm -rf ./organizations/fabric-ca/ordererOrg || true
rm -rf ./channel-artifacts || true
rm -rf ./logs || true

rm -rf /home/vm1/hyperledger/peer0org1/production
rm -rf /home/vm1/hyperledger/org1/peer0/data/snapshots
rm -rf /home/vm1/hyperledger/peer0org1
rm -rf /home/vm1/hyperledger/org1
rm -rf /home/vm1/hyperledger/production

rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/config_block.json
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/config_block.pb
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/config_update_in_envelope.json
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/config_update.json
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/config_update.pb
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/log.txt
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/modified_config.pb
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/Org1MSPanchors.tx
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/Org1MSPconfig.json
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/Org1MSPmodified_config.json
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/original_config.pb

#remove chaincode added files
rm -rf /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/basic.tar.gz