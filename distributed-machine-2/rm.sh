#!/bin/bash
rm -rf ./organizations/peerOrganizations || true
rm -rf ./organizations/ordererOrganizations || true
rm -rf ./organizations/fabric-ca/org1 || true
rm -rf ./organizations/fabric-ca/org2 || true
rm -rf ./organizations/fabric-ca/ordererOrg || true
rm -rf ./channel-artifacts || true
rm -rf ./logs || true

rm -rf /home/vm2/hyperledger/peer0org2/production
rm -rf /home/vm2/hyperledger/org2/peer0/data/snapshots
rm -rf /home/vm2/hyperledger/peer0org2
rm -rf /home/vm2/hyperledger/org2
rm -rf /home/vm2/hyperledger/production

rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/config_block.json
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/config_block.pb
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/config_update_in_envelope.json
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/config_update.json
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/config_update.pb
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/log.txt
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/modified_config.pb
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/Org2MSPanchors.tx
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/Org2MSPconfig.json
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/Org2MSPmodified_config.json
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/original_config.pb

# remove chaincode added files
rm -rf /home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/basic.tar.gz