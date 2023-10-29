// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {Exchange} from "../src/Exchange.sol";
import {Token} from "../src/Token.sol";
import {DeploymentHandler} from "../script/DeploymentHandler.s.sol";

contract ExchangeTest is Test {
    Exchange exchange;
    Token token;

    function setUp() external {
        DeploymentHandler handler = new DeploymentHandler();
        (token, exchange) = handler.run();
    }

    function test__exchange_add_liquidity() external {
        vm.startBroadcast();
        token.approve(address(exchange), 1 ether);
        exchange.addLiquidity{value: 1 ether}(1 ether);
        //assertEq(token.balanceOf(address(this)), 1 ether);
        assertEq(address(exchange).balance, 1 ether);
    }
}
