// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        address _airnodeRrp;
        address _airnodeAddress;
        address _registryAddress;
        address _implementationAddress;
    }

    NetworkConfig public activeNetworkConfig;
    uint256 public deployer_key;
    uint256 public DEV_PRIVATE_KEY = vm.envUint("DEV_PRIVATE_KEY");
    string public nftDropName = "Quantomon";
    string public nftDropSymbol = "QTM";
    uint256 public nftDropInterval = 1 minutes;
    string public questNFTURL =
        "https://bafybeif6h4vucihtot4c3niqajx73jdpuwq2d2j2xegr5d6y33ipub46si.ipfs.nftstorage.link/";

    constructor() {
        if (block.chainid == 80001) {
            activeNetworkConfig = getMumbaiConfigs();
            deployer_key = DEV_PRIVATE_KEY;
        }
    }

    function getMumbaiConfigs() public view returns (NetworkConfig memory mumbaiConfigs) {
        mumbaiConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airnodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC
        });
    }
}
