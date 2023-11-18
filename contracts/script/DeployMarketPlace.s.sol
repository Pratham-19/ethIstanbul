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

        vm.startBroadcast();
        MarketPlace marketPlace = new MarketPlace(
                mostRecentNFTDrop
        );
        vm.stopBroadcast();

        console.log("MarketPlace deployed at: %s", address(marketPlace));
        return address(marketPlace);
    }
}
