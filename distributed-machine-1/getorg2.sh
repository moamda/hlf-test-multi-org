mkdir -p /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/organizations/peerOrganizations/org2.example.com/msp/cacerts
mkdir -p /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/organizations/peerOrganizations/org2.example.com/tlsca

scp -r vm2@2.2.2.2:/home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/organizations/peerOrganizations/org2.example.com/msp /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/organizations/peerOrganizations/org2.example.com/

scp -r vm2@2.2.2.2:/home/vm2/hyperledger/fabric/fabric-samples/distributed-machine-2/organizations/peerOrganizations/org2.example.com/tlsca /home/vm1/hyperledger/fabric/fabric-samples/distributed-machine-1/organizations/peerOrganizations/org2.example.com/

