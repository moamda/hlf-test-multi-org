export FABRIC_CFG_PATH=$PWD/configtx/
export PATH=${PWD}/../bin:$PATH

# export CORE_PEER_TLS_ENABLED=true
# export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
# export PEER0_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
# export PEER1_ORG1_CA=${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem
# export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
# export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key

. scripts/envVar.sh
. scripts/configUpdate.sh
. scripts/utils.sh

createGenesisBlock() {
    configtxgen -profile ChannelUsingRaft -outputBlock ./channel-artifacts/$CHANNEL_NAME/${CHANNEL_NAME}.block -channelID $CHANNEL_NAME

}

createChannel() {
    setGlobalForOrderer0
    osnadmin channel join --channelID $CHANNEL_NAME --config-block ./channel-artifacts/$CHANNEL_NAME/${CHANNEL_NAME}.block -o 192.168.0.73:7053 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY" >logs/osn0admin.log 2>&1
    cat ./logs/osn0admin.log

    setGlobalForOrderer1
    osnadmin channel join --channelID $CHANNEL_NAME --config-block ./channel-artifacts/$CHANNEL_NAME/${CHANNEL_NAME}.block -o 192.168.0.74:7053 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY" >logs/osn1admin.log 2>&1
    cat ./logs/osn1admin.log

}

setGlobalForOrderer0() {
    export CORE_PEER_TLS_ENABLED=true
    export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
    export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
    export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key
}

setGlobalForOrderer1() {
    export CORE_PEER_TLS_ENABLED=true
    export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
    export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.crt
    export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer2.example.com/tls/server.key
}

ORG="1"
CHANNEL_NAME="channel1"
echo $CHANNEL_NAME

# setGlobals 1 # 1 means which organization is being used.

createGenesisBlock
createChannel

# channel sequence
# 1 - createGenesisBlock, done by orderer org
# 2 - createChannel, done by orderer org
# 3 - joinChannel, done by org1
# 4 - createAnchorPeerUpdate, done by org1
# 5 - updateAnchorPeer, done by org1

# Note !!!
# Updating anchor peer is made once only by org1
# if you have other peers are not yet join
# just set the environment variable of that specific peer of organization
# then you can join that peer to the channel.

# Set the environtment variable of peer1 to join channel
# 6 - 'setGlobals 1' or use the function 'setGlobalsForPeer1Org1'
# 7 - joinChannel
