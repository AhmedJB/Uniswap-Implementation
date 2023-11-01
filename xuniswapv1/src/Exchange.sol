// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract Exchange {
    // libs
    using SafeERC20 for IERC20;
    // errors
    error Exchange__Invalid_address();
    error Exchange__Invalid_Reserves();

    address public immutable i_token;
    uint16 constant BASE = 10_000;

    constructor(address _token) {
        if (_token == address(0)) {
            revert Exchange__Invalid_address();
        }

        i_token = _token;
    }

    // add liquidity
    function addLiquidity(uint256 _amount) public payable {
        IERC20 token = IERC20(i_token);
        token.safeTransferFrom(msg.sender, address(this), _amount);
    }

    function getReserve() public view returns (uint256) {
        return IERC20(i_token).balanceOf(address(this));
    }

    function getPrice(
        uint256 inputReserve,
        uint256 outputReserve
    ) public pure returns (uint256) {
        if (inputReserve == 0 && outputReserve == 0) {
            revert Exchange__Invalid_Reserves();
        }

        return (inputReserve * BASE) / outputReserve;
    }
}
