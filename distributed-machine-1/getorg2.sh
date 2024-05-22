mkdir -p /home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org2.example.com/msp/cacerts
mkdir -p /home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org2.example.com/tlsca

scp -r vm2@192.168.0.153:/home/vm2/hlf-test-multi-org/distributed-machine-2/organizations/peerOrganizations/org2.example.com/msp /home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org2.example.com/

scp -r vm2@192.168.0.153:/home/vm2/hlf-test-multi-org/distributed-machine-2/organizations/peerOrganizations/org2.example.com/tlsca /home/vm1/hlf-test-multi-org/distributed-machine-1/organizations/peerOrganizations/org2.example.com/

