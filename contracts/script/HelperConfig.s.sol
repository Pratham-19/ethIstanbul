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
        address _tokenAddress;
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
        } else if (block.chainid == 100) {
            activeNetworkConfig = getXDaiConfigs();
        } else if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaConfigs();
        } else if (block.chainid == 5) {
            activeNetworkConfig = getGoerliConfigs();
        } else if (block.chainid == 421613) {
            activeNetworkConfig = getARBGoerliConfigs();
        } else if (block.chainid == 84531) {
            activeNetworkConfig = getBaseGoerliConfigs();
        } else if (block.chainid == 59144) {
            activeNetworkConfig = getLineaConfigs();
        } else if (block.chainid == 1442) {
            activeNetworkConfig = getPolygonZkEVMTestnetConfigs();
        } else if (block.chainid == 534351) {
            activeNetworkConfig = getScrollSepoliaConfigs();
        } else if (block.chainid == 50) {
            activeNetworkConfig = getXDCConfigs();
        } else if (block.chainid == 44787) {
            activeNetworkConfig = getCeloConfigs();
        } else if (block.chainid == 88880) {
            activeNetworkConfig = getChilizConfigs();
        } else {
            revert("Invalid network");
        }
        deployer_key = DEV_PRIVATE_KEY;
    }

    function getMumbaiConfigs() public pure returns (NetworkConfig memory mumbaiConfigs) {
        mumbaiConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _endPointIdUint256: 0x94555f83f1addda23fdaa7c74f27ce2b764ed5cc430c66f5ff1bcf39d583da36,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC,
            _automate: 0xB3f5503f93d5Ef84b06993a1975B9D21B962892F,
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab,
            _tokenAddress: 0x0FA8781a83E46826621b3BC094Ea2A0212e71B23 // USDC
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
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab,
            _tokenAddress: 0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83 // USDC on Mainnnet
        });
    }

    function getSepoliaConfigs() public pure returns (NetworkConfig memory sepoliaConfigs) {
        sepoliaConfigs = NetworkConfig({
            _airnodeRrp: 0x2ab9f26E18B64848cd349582ca3B55c2d06f507d,
            _airNodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _endPointIdUint256: 0x94555f83f1addda23fdaa7c74f27ce2b764ed5cc430c66f5ff1bcf39d583da36,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, // dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, // dummy
            _automate: 0x8aB6aDbC1fec4F18617C9B889F5cE7F28401B8dB, // doesn't matter
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // doesn't matter
            _tokenAddress: 0x5d00fab5f2F97C4D682C1053cDCAA59c2c37900D // GHO
        });
    }

    function getGoerliConfigs() public pure returns (NetworkConfig memory goerliConfigs) {
        goerliConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _endPointIdUint256: 0x94555f83f1addda23fdaa7c74f27ce2b764ed5cc430c66f5ff1bcf39d583da36,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC,
            _automate: 0xa5f9b728ecEB9A1F6FCC89dcc2eFd810bA4Dec41,
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab,
            _tokenAddress: 0x328507DC29C95c170B56a1b3A758eB7a9E73455c // APE
        });
    }

    function getARBGoerliConfigs() public pure returns (NetworkConfig memory arbGoerliConfigs) {
        arbGoerliConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D,
            _endPointIdUint256: 0x94555f83f1addda23fdaa7c74f27ce2b764ed5cc430c66f5ff1bcf39d583da36,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, //dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, // dummy
            _automate: 0xa5f9b728ecEB9A1F6FCC89dcc2eFd810bA4Dec41,
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab,
            _tokenAddress: 0x2e04466013F09e7caACd185B4E71A370c8deB8d1 // dummy USDC
        });
    }

    //! TODO: Mainnet
    function getBaseGoerliConfigs() public pure returns (NetworkConfig memory baseGoerliConfigs) {
        baseGoerliConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd, //dummy
            _airNodeAddress: 0x6238772544f029ecaBfDED4300f13A3c4FE84E1D, //dummy
            _endPointIdUint256: 0x94555f83f1addda23fdaa7c74f27ce2b764ed5cc430c66f5ff1bcf39d583da36, //dummy
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC,
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0,
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab,
            _tokenAddress: 0x14dA79a27162Ae6F7B328Ff4908C55af800ac4a6 // MB
        });
    }

    //! TODO: Mainnet
    function getLineaConfigs() public pure returns (NetworkConfig memory lineaGoerliConfigs) {
        lineaGoerliConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x9d3C147cA16DB954873A498e0af5852AB39139f2,
            _endPointIdUint256: 0xfb6d017bb87991b7495f563db3c8cf59ff87b09781947bb1e417006ad7f55a78,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758,
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC,
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0, // dummy
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // dummy
            _tokenAddress: 0x176211869cA2b568f2A7D4EE941E073a821EE1ff // USDC Mainnet
        });
    }

    //! TODO: Mainnet
    function getPolygonZkEVMTestnetConfigs() public pure returns (NetworkConfig memory polygonZkEVMConfigs) {
        polygonZkEVMConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd,
            _airNodeAddress: 0x224e030f03Cd3440D88BD78C9BF5Ed36458A1A25,
            _endPointIdUint256: 0xffd1bbe880e7b2c662f6c8511b15ff22d12a4a35d5c8c17202893a5f10e25284,
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, //dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, //dummy
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0, //dummy
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // dummy
            _tokenAddress: 0xA8CE8aee21bC2A48a5EF670afCc9274C7bbbC035 // USDC Mainnet
        });
    }

    function getScrollSepoliaConfigs() public pure returns (NetworkConfig memory scrollSepoliaConfigs) {
        scrollSepoliaConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd, //dummy
            _airNodeAddress: 0x224e030f03Cd3440D88BD78C9BF5Ed36458A1A25, //dummy
            _endPointIdUint256: 0xffd1bbe880e7b2c662f6c8511b15ff22d12a4a35d5c8c17202893a5f10e25284, //dummy
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, //dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, //dummy
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0, //dummy
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // dummy
            _tokenAddress: 0xA8CE8aee21bC2A48a5EF670afCc9274C7bbbC035 //dummy
        });
    }

    function getXDCConfigs() public pure returns (NetworkConfig memory xdcConfigs) {
        xdcConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd, //dummy
            _airNodeAddress: 0x224e030f03Cd3440D88BD78C9BF5Ed36458A1A25, //dummy
            _endPointIdUint256: 0xffd1bbe880e7b2c662f6c8511b15ff22d12a4a35d5c8c17202893a5f10e25284, //dummy
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, //dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, //dummy
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0, //dummy
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // dummy
            _tokenAddress: 0xA8CE8aee21bC2A48a5EF670afCc9274C7bbbC035 //dummy
        });
    }

    function getCeloConfigs() public pure returns (NetworkConfig memory celoConfigs) {
        celoConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd, //dummy
            _airNodeAddress: 0x224e030f03Cd3440D88BD78C9BF5Ed36458A1A25, //dummy
            _endPointIdUint256: 0xffd1bbe880e7b2c662f6c8511b15ff22d12a4a35d5c8c17202893a5f10e25284, //dummy
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, //dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, //dummy
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0, //dummy
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // dummy
            _tokenAddress: 0xA8CE8aee21bC2A48a5EF670afCc9274C7bbbC035 //dummy
        });
    }

    function getChilizConfigs() public pure returns (NetworkConfig memory chilizConfigs) {
        chilizConfigs = NetworkConfig({
            _airnodeRrp: 0xa0AD79D995DdeeB18a14eAef56A549A04e3Aa1Bd, //dummy
            _airNodeAddress: 0x224e030f03Cd3440D88BD78C9BF5Ed36458A1A25, //dummy
            _endPointIdUint256: 0xffd1bbe880e7b2c662f6c8511b15ff22d12a4a35d5c8c17202893a5f10e25284, //dummy
            _registryAddress: 0x000000006551c19487814612e58FE06813775758, //dummy
            _implementationAddress: 0x41C8f39463A868d3A88af00cd0fe7102F30E44eC, //dummy
            _automate: 0x2501648Bf32e6ea8804d4603e3794f651CCEceC0, //dummy
            _taskCreator: 0xA5eE9ef0908055c584Ada82501e891c5F904d7Ab, // dummy
            _tokenAddress: 0xA8CE8aee21bC2A48a5EF670afCc9274C7bbbC035 //dummy
        });
    }
}
