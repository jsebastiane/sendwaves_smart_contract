require("@nomiclabs/hardhat-waffle");
require('dotenv').config()


module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: "https://eth-rinkeby.alchemyapi.io/v2/L1QY3_hHXX5TSt1YZZ0TaynCm7zTSS4P",
      accounts: ["741fd7c27893081fb0b5279af6eda756bd04816e2c5d658b70f205c090d3b248"]
    }
  }
};
