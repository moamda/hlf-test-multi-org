export FABRIC_CFG_PATH=$PWD/configtx/
export PATH=${PWD}/../bin:$PATH


export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
# export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key


. scripts/envVar.sh
. scripts/configUpdate.sh
. scripts/utils.sh


createGenesisBlock() {
    configtxgen -profile ChannelUsingRaft -outputBlock ./channel-artifacts/$CHANNEL_NAME/${CHANNEL_NAME}.block -channelID $CHANNEL_NAME
    sleep 2

}

createChannel() {
    osnadmin channel join --channelID $CHANNEL_NAME --config-block ./channel-artifacts/$CHANNEL_NAME/${CHANNEL_NAME}.block -o 192.168.0.13:7053 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY" > logs/osnadmin.log 2>&1
    cat ./logs/osnadmin.log
    sleep 2

}

ORG="1"
CHANNEL_NAME="channel1" 
echo $CHANNEL_NAME

setGlobals 1 # 1 means which organization is being used.

createGenesisBlock
createChannel

# channel sequence
# 1 - createGenesisBlock, done by orderer org
# 2 - createChannel, done by orderer org
# 3 - joinChannel, done by org1 
# 4 - createAnchorPeerUpdate

