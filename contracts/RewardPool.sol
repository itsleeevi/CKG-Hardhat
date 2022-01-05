// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract RewardPool is Ownable {
    using SafeMath for uint256;
    using Address for address;

    // instance of CKG token
    IERC20 internal _CKG;

    // instance of SCS token
    IERC20 internal _SCS;

    //-------------------------------------------------------------------------
    // CONSTRUCTOR
    //-------------------------------------------------------------------------

    constructor(address CKG, address SCS) {
        _CKG = IERC20(CKG);
        _SCS = IERC20(SCS);
    }

    //-------------------------------------------------------------------------
    // VIEW FUNCTIONS
    //-------------------------------------------------------------------------

    function getBalanceCKG() external view returns (uint256) {
        return _CKG.balanceOf(address(this)).div(10**18);
    }

    function getBalanceSCS() external view returns (uint256) {
        return _SCS.balanceOf(address(this)).div(10**18);
    }

    //-------------------------------------------------------------------------
    // SET FUNCTIONS
    //-------------------------------------------------------------------------

    function setCKG(address CKG) external onlyOwner {
        _CKG = IERC20(CKG);
    }

    function setSCS(address SCS) external onlyOwner {
        _SCS = IERC20(SCS);
    }

    //-------------------------------------------------------------------------
    // EXTERNAL FUNCTIONS
    //-------------------------------------------------------------------------

    function withdrawSCS(uint256 amount, address account) external onlyOwner {
        require(_SCS.balanceOf(address(this)) >= amount, "Not enough SCS.");

        _SCS.transfer(account, amount);
    }

    function withdrawCKG(uint256 amount, address account) external onlyOwner {
        require(_CKG.balanceOf(address(this)) >= amount, "Not enough CKG.");

        _CKG.transfer(account, amount);
    }
}
