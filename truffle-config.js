const HDWalletProvider = require('@truffle/hdwallet-provider');
const fs = require('fs');
module.exports = {
  networks: {
    inf_uniswap_goerli: {
      network_id: 5,
      gasPrice: 100000000000,
      provider: new HDWalletProvider(fs.readFileSync('/Users/abhishekjain/Downloads/uniswap-clone-infura-youtube/Untitled.env', 'utf-8'), "https://goerli.infura.io/v3/662b647b834449aeb129bb2a78311e89")
    },
  },
 
  mocha: {},
  compilers: {
    solc: {
      version: "0.8.17"
    }
  }
};
