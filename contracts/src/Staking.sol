// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract Staking {
    event Staking__Staked(address indexed staker, uint256 indexed amount);
    event Staking__RewardDistributed();

    mapping(address => uint256) public stakes;

    address[] public addressToReward;

    constructor() {}

    function stake() external payable {
        stakes[msg.sender] += msg.value;
        emit Staking__Staked(msg.sender, msg.value);
    }

    function distributeRewards() external {
        getAddressToReward();
        for (uint256 i = 0; i < addressToReward.length; i++) {
            payable(addressToReward[i]).transfer(1 ether);
        }
        emit Staking__RewardDistributed();
    }

    function getAddressToReward() internal view {
        //...
    }

    receive() external payable {}

    fallback() external payable {}
}
