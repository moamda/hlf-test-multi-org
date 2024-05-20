mkdir -p ${PWD}/organizations/peerOrganizations/org1.example.com/tlsca

scp -r vm1@192.168.10.201:/home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/channel-artifacts ${PWD}
mkdir -p ${PWD}/organizations/ordererOrganizations/example.com/
scp -r vm1@192.168.10.201:/home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/organizations/ordererOrganizations/example.com/tlsca ${PWD}/organizations/ordererOrganizations/example.com
scp -r vm1@192.168.10.201:/home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/organizations/peerOrganizations/org1.example.com/tlsca ${PWD}/organizations/peerOrganizations/org1.example.com/