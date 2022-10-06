const CollationContract = artifacts.require('CollationContract');

module.exports = function (deployer) {
    deployer.deploy(CollationContract);
};