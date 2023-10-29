// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {Exchange} from "../src/Exchange.sol";
import {Token} from "../src/Token.sol";

contract DeploymentHandler is Script {
    uint256 constant INITIAL_SUPPLY = 100_000 ether;

    function run() external returns (Token, Exchange) {
        vm.startBroadcast();
        Token _token = new Token("Token Test", "TOK1", INITIAL_SUPPLY);
        Exchange _exchange = new Exchange(address(_token));
        vm.stopBroadcast();
        return (_token, _exchange);
    }
}
