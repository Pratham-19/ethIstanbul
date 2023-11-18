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
    string public nftDropBaseURL =
        "https://bafybeiae7j2yx3ikp6fwgkqfxxq2cnccppovybd7guuk27eaeqhrlsf2la.ipfs.nftstorage.link/test";
    address[] public addressesToReward = [
        0xa60f738a60BCA515Ac529b7335EC7CB2eE3891d2,
        0xdDCc06f98A7C71Ab602b8247d540dA5BD8f5D2A2,
        0x566771D19FD088eE190e37C38d530a71453A5A31,
        0xbd394F796af6dBF94896D7F0e43524b53F32199d
    ];

    constructor() {
        if (block.chainid == 80001) {
            activeNetworkConfig = getMumbaiConfigs();
            deployer_key = DEV_PRIVATE_KEY;
        }
    }

    function getMumbaiConfigs() public pure returns (NetworkConfig memory mumbaiConfigs) {
        mumbaiConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airnodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC
        });
    }
}
