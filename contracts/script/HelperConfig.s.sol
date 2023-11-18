// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    struct NetworkConfig {
        address _airnodeRrp;
        address _airNodeAddress;
        bytes32 _endPointIdUint256;
        address _registryAddress;
        address _implementationAddress;
        address _automate;
        address _taskCreator;
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
    address public sponsorWallet = 0x596C5207c1d28a0EEf6eA0E17b6eb52fA0A076F1;

    constructor() {
        if (block.chainid == 80001) {
            activeNetworkConfig = getMumbaiConfigs();
            deployer_key = DEV_PRIVATE_KEY;
        } else if (block.chainid == 100) {
            activeNetworkConfig = getXDaiConfigs();
            deployer_key = DEV_PRIVATE_KEY;
        } else {
            revert("Invalid network");
        }
    }

    function getMumbaiConfigs() public pure returns (NetworkConfig memory mumbaiConfigs) {
        mumbaiConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _endPointIdUint256: 0x94555f83f1addda23fdaa7c74f27ce2b764ed5cc430c66f5ff1bcf39d583da36,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC,
            _automate: 0xB3f5503f93d5Ef84b06993a1975B9D21B962892F,
            _taskCreator: 0x527a819db1eb0e34426297b03bae11F2f8B3A19E
        });
    }

    function getXDaiConfigs() public pure returns (NetworkConfig memory gnosisConfigs) {
        gnosisConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x224e030f03Cd3440D88BD78C9BF5Ed36458A1A25,
            _endPointIdUint256: 0xffd1bbe880e7b2c662f6c8511b15ff22d12a4a35d5c8c17202893a5f10e25284,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC,
            _automate: 0x8aB6aDbC1fec4F18617C9B889F5cE7F28401B8dB,
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab
        });
    }
}
