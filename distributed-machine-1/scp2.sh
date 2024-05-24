export PATH=${PWD}/../bin:$PATH

. scripts/utils.sh


infoln "copy org1-P0 admin certs"
mkdir ${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/admincerts

scp -r vm1@192.168.0.151:/home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/signcerts/cert.pem /home/vm2/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/admincerts/cert.pem






infoln "copy orderer admin certs"
mkdir ${PWD}/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/admincerts

scp -r vm3@192.168.0.154:/home/vm3/hlf-test-multi-org/distributed-machine-1/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp/signcerts/cert.pem /home/vm2/hlf-test-multi-org/distributed-machine-1/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/admincerts/cert.pem