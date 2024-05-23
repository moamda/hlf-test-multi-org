#!/bin/bash

export PATH=${PWD}/../bin:$PATH

. scripts/utils.sh

echo
infoln "Starting peer0 org1"
echo

mkdir ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/admincerts
cp ${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/admincerts/cert.pem


export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/
export FABRIC_CFG_PATH=${PWD}
export FABRIC_LOGGING_SPEC=INFO
#export FABRIC_LOGGING_SPEC=DEBUG
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_PROFILE_ENABLED=false
export CORE_PEER_TLS_CERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt
export CORE_PEER_TLS_KEY_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
      # Peer specific variables
export CORE_PEER_ID=peer0.org1.example.com
export CORE_PEER_ADDRESS=192.168.0.151:7051
export CORE_PEER_LISTENADDRESS=192.168.0.151:7051
export CORE_PEER_CHAINCODEADDRESS=192.168.0.151:7052
export CORE_PEER_CHAINCODELISTENADDRESS=192.168.0.151:7052
export CORE_PEER_GOSSIP_BOOTSTRAP=192.168.0.151:7051
export CORE_PEER_GOSSIP_EXTERNALENDPOINT=192.168.0.151:7051
export CORE_PEER_LOCALMSPID=Org1MSP
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp
export CORE_OPERATIONS_LISTENADDRESS=192.168.0.151:9444
export CORE_METRICS_PROVIDER=prometheus
export CHAINCODE_AS_A_SERVICE_BUILDER_CONFIG={"peername":"peer0org1"}
export CORE_CHAINCODE_EXECUTETIMEOUT=300s
export CORE_PEER_FILESYSTEMPATH=/home/vm1/hlf-test-multi-org/peer0org1/production
export CORE_LEDGER_SNAPSHOTS_ROOTDIR=/home/vm1/hlf-test-multi-org/org1/peer0/data/snapshots

peer node start > logs/peer0-org1.log 2>&1 &



