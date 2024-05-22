
export PATH=${PWD}/../bin:$PATH
. scripts/utils.sh

mkdir logs

echo
infoln "Starting ca org1"
echo

export FABRIC_CA_HOME=./organizations/fabric-ca/org1
export FABRIC_CA_SERVER_CA_NAME=ca-org1
export FABRIC_CA_SERVER_TLS_ENABLED=true
export FABRIC_CA_SERVER_ADDRESS=192.168.0.151
export FABRIC_CA_SERVER_PORT=7054
export FABRIC_CA_SERVER_OPERATIONS_LISTENADDRESS=192.168.0.151:17054
export FABRIC_CA_SERVER_CSR_HOSTS="localhost,192.168.0.151"

fabric-ca-server start -b admin:adminpw -d > logs/ca-org1.log 2>&1 &

successln "Done..."

