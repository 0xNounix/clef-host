# geth-host

## Overview

This is a simple clef host that can be used by a test net mining node.


## Setup



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

