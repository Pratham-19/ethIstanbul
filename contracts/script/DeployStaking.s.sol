// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Staking} from "../src/Staking.sol";

contract DeployNFTDrop is Script {
    HelperConfig public helperConfig;
    Staking public staking;

    function run() external returns (address) {
        helperConfig = new HelperConfig();

        vm.startBroadcast();
        staking = new Staking();
        console.log("Staking deployed at: %s", address(staking));
        vm.stopBroadcast();

        return address(staking);
    }
}
