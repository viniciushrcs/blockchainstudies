const TrackingAndPayment = artifacts.require("TrackingAndPayment");

module.exports = function (deployer) {
  deployer.deploy(TrackingAndPayment, "0x553B0E50955a3bd0356165980fF82F5A4cb029d9", "0x5d663ccFC3AA02C2F03Ed6Fa55eb5aDd809ff6d0", "0x4491297Ef5060665CD08138f7e12588D32F7Ba0E");
};
