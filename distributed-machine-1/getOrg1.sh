mkdir -p /home/vm3/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/msp/cacerts
mkdir -p /home/vm3/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/tlsca

scp -r vm1@192.168.43.151:/home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/msp /home/vm3/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/

scp -r vm1@192.168.43.151:/home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/tlsca /home/vm3/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org1.example.com/

