# clef-host

## What's all this then?

This is a simple geth/clef host that can be used by a testnet that mines using the "clique" protocol.

## What problem are we trying to solve?

Testnets don't have scale which creates the risk of the network being spammed or interrupted by other means by jerks.  A way around this problem is to create a private network where trusted participants are approved to validate transaction blocks using the clique "proof of authority" (POA) protocol.  The clique POA protocol defines this process as "sealing" transactions.  To seal transactions, a node of an approved miner has to have a secret key available on the node. As this secret key (with its corresponding public "wallet" address) accumulates the transaction fees of the blocks it seals, the key is also required to be available to the node owner in a tool such as metamask so that they can transfer these tokens to others who want to use the testnet.  And so problem #1 we are trying to solve is the process of creating and sharing a key between signing nodes, and the owner who controls them.

Nodes need access to keys to seal transactions, however the problem is that the node software process is by necessity exposed to public queries, including those from jerks.  This means that if the node is poorly configured, compromised through its application interface, or if its host container account is accessed, the node software becomes a risk for secret key compromise if it has direct access to signing keys.  And so problem #2 we are trying to solve is the management of the secret key on the node used to seal transactions so that it is not at risk of disclosure or misuse if the ethereum node software gets pwned.

## The Solutions

The solutions provided in the note are based on geth and clef and are installed on Debian linux using the provided Host Standard Operating Model.

### Overview
* The solution to problem #1 is this document that shows the bash foo required to independantly create a random key and install it into both a geth keystore for use by clef, and metamask for use by a human.
* The solution to problem #2 is the clef-host program provided in this repository.  In simple terms this program runs an ethereum geth node application as a client of the clef external signing application.  This is a tad involved - clef and geth have to run in separate host user accounts with the geth node open to requests through the firewall, and the clef node not open to any requests other than via a shared pipe with geth.  clef requires a user entered password on startup from some form of GUI, and so we have to create a host program feature that acts as a gui for clef to provide the password on startup.  And as clef has to start before geth, we have to manage the process in order.  






### Key Generation

A node needs a key which which it can sign transactions - a process that is called "sealing" in the clique POA process.  The key point about sealing is that a sealing key is paid the transaction fees for the blocks that it seals (signs), and so it accumulates tokens that can be used to access the test network.  This means that the key used at a node to seal transactions has to be available to the person that controls the node so that they can transfer the tokens to themselves or others so that they can use the testnet.  For this reason we generate a key using a non tool specific way so that we can then load the key into both the node keystore that will be signing transactions, and a wallet tool such as metamask so that we can transfer the value held by the key to another address.

A simple way to generate a key on linux is to use the hardware random number generator.

```
    echo "$(sudo xxd -c 64 -l 32 -p /dev/hwrng)" > seal.key
```

We also need a password file to encrypt the key (remember the password you use for the clef setup).

```
    echo -n "Password:" &&  read -s PWD && echo $PWD > seal.pwd && echo ""
```

### Clef Setup

Clef is a trust manager for geth.  Geth is able to 

This means that clef will approve transactions based on scripts that are approved by you, and it can also sign approved transactions with passwords you have approved clef to use.  


./geth-alltools-linux-amd64-1.10.26-e5eb32ac/clef init --configdir . 
./geth-alltools-linux-amd64-1.10.26-e5eb32ac/geth --keystore . account import seal.skey 
(save the address from above to use below)
./geth-alltools-linux-amd64-1.10.26-e5eb32ac/clef --keystore . --configdir . setpw b5dc2103312cfee37504e0aff7652f6a5e57624f
./geth-alltools-linux-amd64-1.10.26-e5eb32ac/clef --configdir . attest /home/z/base/code/nnix/clef/etc/clef-seal-rule.js

