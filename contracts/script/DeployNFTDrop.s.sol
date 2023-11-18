// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {NFTDrop} from "../src/NFTDrop.sol";

contract DeployNFTDrop is Script {
    HelperConfig public helperConfig;
    NFTDrop public nftDrop;

    function run() external returns (address) {
        helperConfig = new HelperConfig();
        (
            address _airnodeRrp,
            address _airNodeAddress,
            bytes32 _endPointIdUint256,
            ,
            ,
            address _automate,
            address _taskCreator
        ) = helperConfig.activeNetworkConfig();
        string memory _nftDropName = helperConfig.nftDropName();
        string memory _nftDropSymbol = helperConfig.nftDropSymbol();
        uint256 _interval = helperConfig.nftDropInterval();

        vm.startBroadcast();
        nftDrop = new NFTDrop(_nftDropName, _nftDropSymbol, _interval, _airnodeRrp,
        _airNodeAddress,
        _endPointIdUint256, _automate, _taskCreator);
        console.log("NFTDrop deployed at: %s", address(nftDrop));
        vm.stopBroadcast();

        return address(nftDrop);
    }
}
