# Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, and a script that deploys that contract.

Try running some of the following tasks:

```shell
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat run scripts/deploy.js
```
0x1263eC27FA9B1c4665d66a8961152F39A6c655de testnet bsc

TO Do :
- faire marcher la fonction create pair dans le contrat pool
- faire les fees dans la fonction transfer de MyToken

- Faire la fonction pour changer de token --> mais quels tokens exactement ???? exactment
- Faire un front en localHost React pour juste changer de token et ajouter/retirer de la blacklist


QUESTIONS :

- Comment c'est possible que je me sois fait drain mes bnb test ?
- commment faire des tests sur testnet sans payer de gas fees ?
- Comment reproduire le swap de pancake dans un contrat le plu simple possible ?