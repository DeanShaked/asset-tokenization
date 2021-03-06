pragma solidity ^0.6.1;

import "./CrowdSale.sol";
import "./kycContract.sol";

contract MyTokenSale is CrowdSale {

    KycContract kyc;
    constructor(
        uint256 rate,    // rate in TKNbits
        address payable wallet,
        IERC20 token,
        KycContract _kyc
    )
        CrowdSale(rate, wallet, token)
        public
    {
        kyc = _kyc;
    }

    function _preValidatePurchase(address beneficiary, uint256 weiAmount) internal view override {
        super._preValidatePurchase(beneficiary,weiAmount);
        require(kyc.kycCompleted(msg.sender),"KYC is not completed, purchase is not allowed");
    }
}