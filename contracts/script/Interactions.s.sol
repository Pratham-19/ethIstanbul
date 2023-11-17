// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

import {HelperConfig} from "./HelperConfig.s.sol";
import {QuestNFT} from "../src/QuestNFT.sol";

contract CreateQuestNFT is Script {
    function delegateGovernanceToken(address _questNFTAddress, uint256 deployer_key) public {
        vm.startBroadcast(deployer_key);

        QuestNFT questNFT = QuestNFT(_questNFTAddress);
        questNFT.mint(msg.sender);

        vm.stopBroadcast();
    }

    function createQuestUsingConfigs() public {
        address mostRecentlyDeployedQuestNFT = DevOpsTools.get_most_recent_deployment("QuestNFT", block.chainid);
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        delegateGovernanceToken(mostRecentlyDeployedQuestNFT, deployer_key);
    }

    function run() public {
        createQuestUsingConfigs();
    }
}
