export FABRIC_CFG_PATH=$PWD/configtx
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
    setGlobalsForPeer0Org1
    peer channel join -b $BLOCKFILE > logs/$CHANNEL_NAME.log
    sleep 1

    setGlobalsForPeer1Org1
    peer channel join -b $BLOCKFILE > logs/$CHANNEL_NAME.log
    sleep 1

}

createAnchorPeerUpdate() {
    echo
    infoln "Fetching channel config for channel $CHANNEL_NAME"
    fetchChannelConfig $ORG $CHANNEL_NAME ${CORE_PEER_LOCALMSPID}config.json
    echo

    echo
    infoln "Generating anchor peer update transaction for Org${ORG} on channel $CHANNEL_NAME"
    echo

    if [ $ORG -eq 1 ]; then
      P0HOST="192.168.0.71"
      P0PORT=7051
      P1HOST="192.168.0.72"
      P1PORT=7051
    else
      errorln "Org${ORG} unknown"
    fi

    set -x
    # Modify the configuration to append the anchor peer 
    jq '.channel_group.groups.Application.groups.'${CORE_PEER_LOCALMSPID}'.values += {"AnchorPeers":{"mod_policy": "Admins","value":{"anchor_peers": [{"host": "'$P0HOST'","port": '$P0PORT'},{"host": "'$P1HOST'","port": '$P1PORT'}]},"version": "0"}}' ${CORE_PEER_LOCALMSPID}config.json > ${CORE_PEER_LOCALMSPID}modified_config.json
    { set +x; } 2>/dev/null

    # Compute a config update, based on the differences between 
    # {orgmsp}config.json and {orgmsp}modified_config.json, write
    # it as a transaction to {orgmsp}anchors.tx
   createConfigUpdate ${CHANNEL_NAME} ${CORE_PEER_LOCALMSPID}config.json ${CORE_PEER_LOCALMSPID}modified_config.json ${CORE_PEER_LOCALMSPID}anchors.tx
}

updateAnchorPeer() {
  setGlobalsForPeer0Org1
  peer channel update -o 192.168.0.73:7050 --ordererTLSHostnameOverride 192.168.0.73 -c $CHANNEL_NAME -f ${CORE_PEER_LOCALMSPID}anchors.tx --tls --cafile "$ORDERER_CA" >&log.txt
  res=$?
  cat log.txt
  verifyResult $res "Anchor peer update failed"
  successln "Anchor peer set for org '$CORE_PEER_LOCALMSPID' on channel '$CHANNEL_NAME'"
}

setGlobalsForPeer0Org1(){
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=192.168.0.71:7051
}

setGlobalsForPeer1Org1(){
    export CORE_PEER_LOCALMSPID="Org1MSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER1_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
    export CORE_PEER_ADDRESS=192.168.0.72:7051
}


ORG="1"
CHANNEL_NAME="channel1" #rename onto desired channel name
BLOCKFILE="./channel-artifacts/$CHANNEL_NAME/${CHANNEL_NAME}.block"

echo
echo "channel: $CHANNEL_NAME"
echo

joinChannel 
createAnchorPeerUpdate 
updateAnchorPeer







