scp -r vm3@192.168.0.13:/home/vm3/hlf-test-multi-org/distributed-machine-orderer/channel-artifacts ${PWD}
mkdir -p ${PWD}/organizations/ordererOrganizations/example.com/
scp -r vm3@192.168.0.13:/home/vm3/hlf-test-multi-org/distributed-machine-orderer/organizations/ordererOrganizations/example.com/tlsca ${PWD}/organizations/ordererOrganizations/example.com
