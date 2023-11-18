// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {HelperConfig} from "./HelperConfig.s.sol";
import {MarketPlace} from "../src/Marketplace.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract DeployMarketPlace is Script {
    function run() public returns (address) {
        address mostRecentNFTDrop = DevOpsTools.get_most_recent_deployment("NFTDrop", block.chainid);
        address USDC_TOKEN_ADDRESS = 0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83;

        vm.startBroadcast();
        MarketPlace marketPlace = new MarketPlace(
                mostRecentNFTDrop, USDC_TOKEN_ADDRESS
        );
        vm.stopBroadcast();

        console.log("MarketPlace deployed at: %s", address(marketPlace));
        return address(marketPlace);
    }
}
