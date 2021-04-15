const TrackingAndPayment = artifacts.require("TrackingAndPayment");

module.exports = function (deployer) {
  deployer.deploy(TrackingAndPayment, "0x541035d3d8Df867a1736509A6909e9E54F0Ad8F0", "0x81b7BDE6789e7E5F6D2BcD31E709d46779905F6e", "0x8892de86313f8B454f71c5d4a72d24d40BF3C8C2");
};
