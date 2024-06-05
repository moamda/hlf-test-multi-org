export PATH=${PWD}/../bin:$PATH
. scripts/utils.sh

echo
infoln "Enrolling the CA admin"
echo

mkdir -p organizations/peerOrganizations/org1.example.com/

export FABRIC_CA_CLIENT_HOME=${PWD}/organizations/peerOrganizations/org1.example.com/

set -x
fabric-ca-client enroll -u https://admin:adminpw@192.168.0.71:7054 --caname ca-org1 --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/192-168-0-71-7054-ca-org1.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/192-168-0-71-7054-ca-org1.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/192-168-0-71-7054-ca-org1.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/192-168-0-71-7054-ca-org1.pem
    OrganizationalUnitIdentifier: orderer' >"${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml"

# Since the CA serves as both the organization CA and TLS CA, copy the org's root cert that was generated by CA startup into the org level ca and tlsca directories

# Copy org1's CA cert to org1's /msp/tlscacerts directory (for use in the channel MSP definition)
mkdir -p "${PWD}/organizations/peerOrganizations/org1.example.com/msp/tlscacerts"
cp "${PWD}/organizations/fabric-ca/org1/ca-cert.pem" "${PWD}/organizations/peerOrganizations/org1.example.com/msp/tlscacerts/ca.crt"

# Copy org1's CA cert to org1's /tlsca directory (for use by clients)
mkdir -p "${PWD}/organizations/peerOrganizations/org1.example.com/tlsca"
cp "${PWD}/organizations/fabric-ca/org1/ca-cert.pem" "${PWD}/organizations/peerOrganizations/org1.example.com/tlsca/tlsca.org1.example.com-cert.pem"

# Copy org1's CA cert to org1's /ca directory (for use by clients)
mkdir -p "${PWD}/organizations/peerOrganizations/org1.example.com/ca"
cp "${PWD}/organizations/fabric-ca/org1/ca-cert.pem" "${PWD}/organizations/peerOrganizations/org1.example.com/ca/ca.org1.example.com-cert.pem"

echo
infoln "Registering peer0"
echo

set -x
fabric-ca-client register --caname ca-org1 --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

echo
infoln "Registering peer1"
echo

set -x
fabric-ca-client register --caname ca-org1 --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

echo
infoln "Registering user"
echo

set -x
fabric-ca-client register --caname ca-org1 --id.name user1 --id.secret user1pw --id.type client --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

echo
infoln "Registering the org admin"
echo

set -x
fabric-ca-client register --caname ca-org1 --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

echo
infoln "Generating the peer0 msp"
echo

set -x
fabric-ca-client enroll -u https://peer0:peer0pw@192.168.0.71:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/msp/config.yaml"

echo
infoln "Generating the peer0-tls certificates, use --csr.hosts to specify Subject Alternative Names"
echo

set -x
fabric-ca-client enroll -u https://peer0:peer0pw@192.168.0.71:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls" --enrollment.profile tls --csr.hosts peer0.org1.example.com --csr.hosts 192.168.0.71 --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

# Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
cp "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt"
cp "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.crt"
cp "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/server.key"

echo
infoln "Generating the peer1 msp"
echo

set -x
fabric-ca-client enroll -u https://peer1:peer1pw@192.168.0.71:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/msp/config.yaml"

echo
infoln "Generating the peer1-tls certificates, use --csr.hosts to specify Subject Alternative Names"
echo

set -x
fabric-ca-client enroll -u https://peer1:peer1pw@192.168.0.71:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls" --enrollment.profile tls --csr.hosts peer1.org1.example.com --csr.hosts 192.168.0.72 --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

# Copy the tls CA cert, server cert, server keystore to well known file names in the peer's tls directory that are referenced by peer startup config
cp "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/tlscacerts/"* "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt"
cp "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/signcerts/"* "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.crt"
cp "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/keystore/"* "${PWD}/organizations/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/server.key"

echo
infoln "Generating the user msp"
echo

set -x
fabric-ca-client enroll -u https://user1:user1pw@192.168.0.71:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/org1.example.com/users/User1@org1.example.com/msp/config.yaml"

echo
infoln "Generating the org admin msp"
echo

set -x
fabric-ca-client enroll -u https://org1admin:org1adminpw@192.168.0.71:7054 --caname ca-org1 -M "${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" --tls.certfiles "${PWD}/organizations/fabric-ca/org1/ca-cert.pem"
{ set +x; } 2>/dev/null

cp "${PWD}/organizations/peerOrganizations/org1.example.com/msp/config.yaml" "${PWD}/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp/config.yaml"

# set -x
# infoln "Generating CCP files"
# ./organizations/ccp-generate.sh
