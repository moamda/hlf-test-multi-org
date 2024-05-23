#!/bin/bash

export PATH=${PWD}/../bin:$PATH

. scripts/utils.sh

echo
infoln "Staring orderer"
echo

mkdir -p  ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/admincerts
cp  ${PWD}/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem  ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/admincerts/cert.pem


export FABRIC_LOGGING_SPEC=INFO
export ORDERER_GENERAL_LISTENADDRESS=192.168.0.154
export ORDERER_GENERAL_LISTENPORT=7050
export ORDERER_GENERAL_LOCALMSPID=OrdererMSP
export ORDERER_GENERAL_LOCALMSPDIR=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp
# enabled TLS
export ORDERER_GENERAL_TLS_ENABLED=true
export ORDERER_GENERAL_TLS_PRIVATEKEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key
export ORDERER_GENERAL_TLS_CERTIFICATE=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_GENERAL_TLS_ROOTCAS=[${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]
export ORDERER_GENERAL_CLUSTER_CLIENTCERTIFICATE=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_GENERAL_CLUSTER_CLIENTPRIVATEKEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key
export ORDERER_GENERAL_CLUSTER_ROOTCAS=[${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]
export ORDERER_GENERAL_BOOTSTRAPMETHOD=none
export ORDERER_CHANNELPARTICIPATION_ENABLED=true
export ORDERER_ADMIN_TLS_ENABLED=true
export ORDERER_ADMIN_TLS_CERTIFICATE=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATEKEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key
export ORDERER_ADMIN_TLS_ROOTCAS=[${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]
export ORDERER_ADMIN_TLS_CLIENTROOTCAS=[${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt]
export ORDERER_ADMIN_LISTENADDRESS=192.168.0.154:7053
export ORDERER_OPERATIONS_LISTENADDRESS=192.168.0.154:9443
export ORDERER_METRICS_PROVIDER=prometheus

orderer > logs/orderer.log 2>&1 &


