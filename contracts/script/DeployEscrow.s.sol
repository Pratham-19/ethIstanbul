// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Escrow} from "../src/Escrow.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract DeployEscrow is Script {
    HelperConfig public helperConfig;
    Escrow public escrow;

    function run() external returns (address) {
        vm.startBroadcast();
        escrow = new Escrow();
        console.log("Escrow deployed at: %s", address(escrow));
        vm.stopBroadcast();

        return address(escrow);
    }
}
