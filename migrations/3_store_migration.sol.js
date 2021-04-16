const Store = artifacts.require("Store");

module.exports = function (deployer) {
  deployer.deploy(Store, "0xedF554aDB2Fa8F8491725F6291bB33351Db06E1A", 6);
};
