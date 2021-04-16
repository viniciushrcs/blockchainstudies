const Store = artifacts.require("Store");

module.exports = function (deployer) {
  deployer.deploy(Store, "100", 2);
};
