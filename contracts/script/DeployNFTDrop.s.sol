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
        (address _airnodeRrp, address _airNodeAddress, bytes32 _endPointIdUint256,,,,,) =
            helperConfig.activeNetworkConfig();
        string memory _nftDropName = helperConfig.nftDropName();
        string memory _nftDropSymbol = helperConfig.nftDropSymbol();
        uint256 _interval = helperConfig.nftDropInterval();
        string memory _baseURI = helperConfig.nftDropBaseURL();

        vm.startBroadcast();
        nftDrop = new NFTDrop(_nftDropName, _nftDropSymbol, 
        _baseURI, _interval, _airnodeRrp, _airNodeAddress,_endPointIdUint256);
        vm.stopBroadcast();

        return address(nftDrop);
    }
}
