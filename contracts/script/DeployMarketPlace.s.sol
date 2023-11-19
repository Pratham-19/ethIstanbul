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
        // Only For Sepolia
        address GHO_TOKEN_ADDRESS = 0x5d00fab5f2F97C4D682C1053cDCAA59c2c37900D;
        // Only For Sepolia
        address _chronicleAddresss = 0x90430C5b8045a1E2A0Fc4e959542a0c75b576439;

        vm.startBroadcast();
        MarketPlace marketPlace = new MarketPlace(
                mostRecentNFTDrop, GHO_TOKEN_ADDRESS, _chronicleAddresss
        );
        vm.stopBroadcast();

        console.log("MarketPlace deployed at: %s", address(marketPlace));
        return address(marketPlace);
    }
}
