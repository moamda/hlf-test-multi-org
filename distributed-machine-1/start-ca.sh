rm -rf ./organizations/peerOrganizations || true
rm -rf ./organizations/ordererOrganizations || true
rm -rf ./organizations/fabric-ca/org1 || true
rm -rf ./organizations/fabric-ca/org2 || true
rm -rf ./organizations/fabric-ca/ordererOrg || true
rm -rf ./channel-artifacts || true
rm -rf ./logs || true

export PATH=${PWD}/../bin:$PATH
. scripts/utils.sh

mkdir logs



infoln "Starting ca org1"