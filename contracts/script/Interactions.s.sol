// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

import {HelperConfig} from "./HelperConfig.s.sol";
import {QuestNFT} from "../src/QuestNFT.sol";
import {Escrow} from "../src/Escrow.sol";

contract CreateQuestNFT is Script {
    function createQuest(address _questNFTAddress, uint256 deployer_key, string memory _uri) public {
        vm.startBroadcast(deployer_key);

        QuestNFT questNFT = QuestNFT(_questNFTAddress);
        (uint256 tokenId, address tbaAddress) = questNFT.mintQuestNFT(msg.sender, _uri);
        vm.stopBroadcast();
        console.log("QuestNFT minted at: %s", address(questNFT));
        console.log("tba address: %s", tbaAddress);
        console.log("tokenId: %s", tokenId);
    }

    function createQuestUsingConfigs() public {
        address mostRecentlyDeployedQuestNFT = DevOpsTools.get_most_recent_deployment("QuestNFT", block.chainid);
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        string memory _questNFTURL = helperConfigs.questNFTURL();

        createQuest(mostRecentlyDeployedQuestNFT, deployer_key, _questNFTURL);
    }

    function run() public {
        createQuestUsingConfigs();
    }
}

contract MintQuestCompletionNFT is Script {
    function mintQuestCompletionNFT(QuestNFT questNFT, uint256 deployer_key, string memory _uri) public {
        vm.startBroadcast(deployer_key);

        questNFT.mintQuestCompletionNFT(msg.sender, _uri);
        vm.stopBroadcast();
        console.log("QuestCompletionNFT minted at: %s", address(questNFT));
    }

    function MintQuestCompletionNFTUsingConfigs() public {
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        address mostRecentlyDeployedQuestNFT = DevOpsTools.get_most_recent_deployment("QuestNFT", block.chainid);
        QuestNFT questNFT = QuestNFT(mostRecentlyDeployedQuestNFT);
        string memory _questCompletionNFTURL = helperConfigs.questNFTURL();

        mintQuestCompletionNFT(questNFT, deployer_key, _questCompletionNFTURL);
    }

    function run() public {
        MintQuestCompletionNFTUsingConfigs();
    }
}

contract Stake is Script {
    function stake(Escrow _escrow, uint256 deployer_key, uint256 stakingAmount) public {
        vm.startBroadcast(deployer_key);

        _escrow.stake{value: stakingAmount}();
        vm.stopBroadcast();
        console.log("Staked at: %s", address(_escrow));
    }

    function stakeUsingConfigs() public {
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        address mostRecentlyDeployedEscrow = DevOpsTools.get_most_recent_deployment("Escrow", block.chainid);
        uint256 stakingAmount = 1 ether;
        Escrow escrow = Escrow(payable(mostRecentlyDeployedEscrow));

        stake(escrow, deployer_key, stakingAmount);
    }

    function run() public {
        stakeUsingConfigs();
    }
}
