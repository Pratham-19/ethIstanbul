// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

import {HelperConfig} from "./HelperConfig.s.sol";
import {QuestNFT} from "../src/QuestNFT.sol";
import {Escrow} from "../src/Escrow.sol";
import {NFTDrop} from "../src/NFTDrop.sol";

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

contract DistributeRewards is Script {
    function distributeRewards(Escrow _escrow, uint256 deployer_key, address[] memory addressesToReward) public {
        vm.startBroadcast(deployer_key);
        _escrow.distributeRewards(addressesToReward);
        vm.stopBroadcast();
        console.log("Rewards distributed at: %s", address(_escrow));
    }

    function distributeRewardsUsingConfigs() public {
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        address mostRecentlyDeployedEscrow = DevOpsTools.get_most_recent_deployment("Escrow", block.chainid);
        Escrow escrow = Escrow(payable(mostRecentlyDeployedEscrow));
        address[] memory addressesToReward = new address[](3);
        addressesToReward[0] = helperConfigs.addressesToReward(0);
        addressesToReward[1] = helperConfigs.addressesToReward(1);
        addressesToReward[2] = helperConfigs.addressesToReward(2);

        distributeRewards(escrow, deployer_key, addressesToReward);
    }

    function run() public {
        distributeRewardsUsingConfigs();
    }
}

contract SetBaseURI is Script {
    function setBaseURI(NFTDrop nftDrop, uint256 deployer_key, string memory baseURL) public {
        vm.startBroadcast(deployer_key);
        nftDrop.setBaseURI(baseURL);
        vm.stopBroadcast();
    }

    function setBaseURIUsingConfigs() public {
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        address mostRecentlyDeployedNFTDrop = DevOpsTools.get_most_recent_deployment("NFTDrop", block.chainid);
        NFTDrop nftDrop = NFTDrop(mostRecentlyDeployedNFTDrop);
        string memory baseURL = helperConfigs.nftDropBaseURL();

        setBaseURI(nftDrop, deployer_key, baseURL);
    }

    function run() public {
        setBaseURIUsingConfigs();
    }
}

contract SetSponsorWallet is Script {
    function setSponsorWallet(NFTDrop nftDrop, uint256 deployer_key, address sponsorWallet) public {
        vm.startBroadcast(deployer_key);
        nftDrop.setSponsorWallet(sponsorWallet);
        vm.stopBroadcast();
    }

    function setSponsorWalletUsingConfigs() public {
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        address mostRecentlyDeployedNFTDrop = DevOpsTools.get_most_recent_deployment("NFTDrop", block.chainid);
        NFTDrop nftDrop = NFTDrop(mostRecentlyDeployedNFTDrop);
        address sponsorWallet = helperConfigs.sponsorWallet();

        setSponsorWallet(nftDrop, deployer_key, sponsorWallet);
    }

    function run() public {
        setSponsorWalletUsingConfigs();
    }
}

contract MintTaskCompletionNFT is Script {
    function mintTaskCompletionNFT(NFTDrop nftDrop, uint256 deployer_key) public {
        vm.startBroadcast(deployer_key);

        nftDrop.mintTaskCompletionNFT(msg.sender);
        vm.stopBroadcast();
        console.log("TaskCompletionNFT minted at: %s", address(nftDrop));
    }

    function mintTaskCompletionNFTUsingConfigs() public {
        HelperConfig helperConfigs = new HelperConfig();
        uint256 deployer_key = helperConfigs.deployer_key();
        address mostRecentlyDeployedNFTDrop = DevOpsTools.get_most_recent_deployment("NFTDrop", block.chainid);
        NFTDrop nftDrop = NFTDrop(mostRecentlyDeployedNFTDrop);

        mintTaskCompletionNFT(nftDrop, deployer_key);
    }

    function run() public {
        mintTaskCompletionNFTUsingConfigs();
    }
}
