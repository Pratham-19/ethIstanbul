// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {QuestNFT} from "../src/QuestNFT.sol";

contract DeployQuestNFT is Script {
    HelperConfig public helperConfig;
    QuestNFT public questNFT;

    function run() external returns (address) {
        helperConfig = new HelperConfig();
        (,,,,,, address _registryAddress, address _implementationAddress) = helperConfig.activeNetworkConfig();
        uint256 chainId = block.chainid;
        uint256 deployer_key = helperConfig.deployer_key();

        vm.startBroadcast(deployer_key);
        questNFT = new QuestNFT(_registryAddress, _implementationAddress, chainId );
        console.log("QuestNFT deployed at: %s", address(questNFT));
        vm.stopBroadcast();

        return address(questNFT);
    }
}
