mkdir -p /home/vm2/hlf-test-multi-org/distributed-machine-org1/organizations/peerOrganizations/org1.example.com/msp/cacerts
mkdir -p /home/vm2/hlf-test-multi-org/distributed-machine-org1/organizations/peerOrganizations/org1.example.com/tlsca

scp -r vm1@192.168.0.151:/home/vm1/hlf-test-multi-org/distributed-machine-org1/organizations/peerOrganizations/org1.example.com/msp /home/vm2/hlf-test-multi-org/distributed-machine-org1/organizations/peerOrganizations/org1.example.com/

scp -r vm1@192.168.0.151:/home/vm1/hlf-test-multi-org/distributed-machine-org1/organizations/peerOrganizations/org1.example.com/tlsca /home/vm2/hlf-test-multi-org/distributed-machine-org1/organizations/peerOrganizations/org1.example.com/

