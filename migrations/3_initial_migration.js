const Seller = artifacts.require("Seller");

module.exports = function (deployer) {
  deployer.deploy(Seller,"0x4aBca7dccB3652b9B43a0F5753B8E1c77fDBD427");
};