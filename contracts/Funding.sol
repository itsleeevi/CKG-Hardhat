// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Funding is Ownable {
    using SafeMath for uint256;
    using Address for address;

    uint256 public fee = 0.0016 ether;
    address payable public minterAccount =
        payable(0xeb10A7d0d7CB5798838433395871C78FBEC70490);

    event FundingTxSent(string externalTransactionId, address player);

    function setMinterAccount(address payable minterAccount_)
        external
        onlyOwner
    {
        require(
            minterAccount_ != address(0),
            "Minter account cannot be null address."
        );
        minterAccount = minterAccount_;
    }

    function setFee(uint256 fee_) external onlyOwner {
        fee = fee_;
    }

    function _forwardFee() internal {
        minterAccount.transfer(fee);
    }

    function payTxFee(string memory externalTransactionId) external payable {
        require(fee == msg.value, "Amount of BNB sent is not correct.");

        _forwardFee();

        emit FundingTxSent(externalTransactionId, msg.sender);
    }
}
