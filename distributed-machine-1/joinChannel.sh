export FABRIC_CFG_PATH=$PWD/configtx/
export PATH=${PWD}/../bin:$PATH


export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key


. scripts/envVar.sh
. scripts/configUpdate.sh
. scripts/utils.sh


joinChannel() {
    peer channel join -b $BLOCKFILE > logs/$CHANNEL_NAME.log
    sleep 2

}


CHANNEL_NAME="mychannel" # default value is mychannel
echo $CHANNEL_NAME

BLOCKFILE="./channel-artifacts/${CHANNEL_NAME}.block"

setGlobals 1
joinChannel 1

