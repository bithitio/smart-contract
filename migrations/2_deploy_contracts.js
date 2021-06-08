const BEP20Token = artifacts.require("BEP20Token");
const EthSwap = artifacts.require("EthSwap");

module.exports = async function(deployer) {
  // Deploy Token
  await deployer.deploy(BEP20Token);
  const token = await BEP20Token.deployed()

  // Deploy EthSwap
  const rate = 390000;
  await deployer.deploy(EthSwap, token.address, rate);
  const ethSwap = await EthSwap.deployed()
  
  await token.transfer(ethSwap.address, '1000000000000000000000000000') //1,000 m.

};
