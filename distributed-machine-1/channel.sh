
# # set -x
export FABRIC_CFG_PATH=$PWD/configtx/
export PATH=${PWD}/../bin:$PATH

export ORDERER_ADMIN_TLS_SIGN_CERT=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.crt
export ORDERER_ADMIN_TLS_PRIVATE_KEY=${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/server.key
export ORDERER_CA=${PWD}/organizations/ordererOrganizations/example.com/tlsca/tlsca.example.com-cert.pem
export CORE_PEER_MSPCONFIGPATH=${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp

# import utils
. scripts/envVar.sh
. scripts/configUpdate.sh

# NOTE: this must be run in a CLI container since it requires jq and configtxlator 
createAnchorPeerUpdate() {
  infoln "Fetching channel config for channel $CHANNEL_NAME"
  fetchChannelConfig $ORG $CHANNEL_NAME ${CORE_PEER_LOCALMSPID}config.json

  infoln "Generating anchor peer update transaction for Org${ORG} on channel $CHANNEL_NAME"

    #   if [ $ORG -eq 1 ]; then
    #       if [ $PEER -eq 0 ]; then
    #           HOST="192.168.0.151"  # IP address of machine hosting peer0 for org1
    #       elif [ $PEER -eq 1 ]; then
    #           HOST="192.168.0.153"  # IP address of machine hosting peer1 for org1
    #       else
    #           errorln "Peer${PEER} unknown"
    #       fi
    #       PORT=7051  # Assuming both peer0 and peer1 use the same port
    #   else
    #       errorln "Org${ORG} unknown"
    #   fi

  if [ $ORG -eq 1 ]; then
    HOST="192.168.0.151"
    PORT=7051
  elif [ $ORG -eq 2 ]; then
    HOST="192.168.0.153"
    PORT=7051
  else
    errorln "Org${ORG} unknown"
  fi

  set -x
  # Modify the configuration to append the anchor peer 
  jq '.channel_group.groups.Application.groups.'${CORE_PEER_LOCALMSPID}'.values += {"AnchorPeers":{"mod_policy": "Admins","value":{"anchor_peers": [{"host": "'$HOST'","port": '$PORT'}]},"version": "0"}}' ${CORE_PEER_LOCALMSPID}config.json > ${CORE_PEER_LOCALMSPID}modified_config.json
  { set +x; } 2>/dev/null

  # Compute a config update, based on the differences between 
  # {orgmsp}config.json and {orgmsp}modified_config.json, write
  # it as a transaction to {orgmsp}anchors.tx
  createConfigUpdate ${CHANNEL_NAME} ${CORE_PEER_LOCALMSPID}config.json ${CORE_PEER_LOCALMSPID}modified_config.json ${CORE_PEER_LOCALMSPID}anchors.tx
}

updateAnchorPeer() {
  peer channel update -o 192.168.0.13:7050 --ordererTLSHostnameOverride orderer.example.com -c $CHANNEL_NAME -f ${CORE_PEER_LOCALMSPID}anchors.tx --tls --cafile "$ORDERER_CA" >&log.txt
  res=$?
  cat log.txt
  verifyResult $res "Anchor peer update failed"
  successln "Anchor peer set for org '$CORE_PEER_LOCALMSPID' on channel '$CHANNEL_NAME'"
}



# Generate System Genesis Block
configtxgen -profile ChannelUsingRaft -outputBlock ./channel-artifacts/mychannel.block -channelID mychannel

sleep 2

osnadmin channel join --channelID mychannel --config-block ./channel-artifacts/mychannel.block -o 192.168.0.13:7053 --ca-file "$ORDERER_CA" --client-cert "$ORDERER_ADMIN_TLS_SIGN_CERT" --client-key "$ORDERER_ADMIN_TLS_PRIVATE_KEY" > logs/osnadmin.log 2>&1

sleep 2

export FABRIC_CFG_PATH=$PWD

# error starts here
setGlobals 1
peer channel join -b channel-artifacts/mychannel.block > logs/channel1.log
sleep 1


ORG="1"
CHANNEL_NAME="mychannel"

setGlobals 1 0

createAnchorPeerUpdate 

updateAnchorPeer 


# channel name defaults to "mychannel"
# CHANNEL_NAME="mychannel"
# echo $CHANNEL_NAME

