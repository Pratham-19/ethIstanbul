// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {QuestNFT} from "../src/QuestNFT.sol";

contract DeployNFTDrop is Script {
    HelperConfig public helperConfig;
    QuestNFT public questNFT;

    function run() external returns (address) {
        helperConfig = new HelperConfig();
        (,, address _registryAddress, address _implementationAddress) = helperConfig.activeNetworkConfig();
        uint256 chainId = block.chainid;
        string memory _questNFTURL = helperConfig.questNFTURL();

        vm.startBroadcast();
        questNFT = new QuestNFT(_registryAddress, _implementationAddress, chainId,_questNFTURL );
        console.log("QuestNFT deployed at: %s", address(questNFT));
        vm.stopBroadcast();

        return address(questNFT);
    }
}
