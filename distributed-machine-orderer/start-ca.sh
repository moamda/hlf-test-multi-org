
export PATH=${PWD}/../bin:$PATH
. scripts/utils.sh

mkdir logs

echo
infoln "Starting ca orderer"
echo

export FABRIC_CA_HOME=./organizations/fabric-ca/ordererOrg
export FABRIC_CA_SERVER_CA_NAME=ca-orderer
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_ADDRESS=192.168.0.73
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_OPERATIONS_LISTENADDRESS=192.168.0.73:17054
export FABRIC_CA_SERVER_CSR_HOSTS="localhost,192.168.0.73,192.168.0.74"

fabric-ca-server start -b admin:adminpw -d > logs/ca-orderer.log 2>&1 &



