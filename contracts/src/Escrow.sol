// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

/**
 * @title Escrow
 * @author Megabyte
 * @notice This is a very basic escrow contract (working as an escrow contract) that allows users to stake ETH and distribute rewards to a list of addresses upon the completion of the quest.
 */
contract Escrow {
    event Escrow__Staked(address indexed staker, uint256 indexed amount);
    event Escrow__RewardDistributed();

    uint256 public constant PRECISION = 1e18;

    mapping(address protocols => uint256 amountStaked) public stakes;

    ////////////////
    // external functions /////
    ////////////////

    /**
     * @notice Stake ETH to the contract.
     */
    function stake() external payable {
        emit Escrow__Staked(msg.sender, msg.value);
        stakes[msg.sender] += msg.value;
    }

    /**
     * This function is called by the main contract to distribute rewards to the list of addresses.
     * @param _addressToReward List of addresses to distribute rewards to.
     */
    function distributeRewards(address[] memory _addressToReward) external {
        uint256 length = _addressToReward.length;
        uint256 precisionAmount = address(this).balance * PRECISION / length;
        uint256 equalAmount = precisionAmount / PRECISION;
        for (uint256 i = 0; i < length;) {
            (bool success,) = _addressToReward[i].call{value: equalAmount}("");
            require(success, "Transfer failed.");
            unchecked {
                i++;
            }
        }
        emit Escrow__RewardDistributed();
    }

    receive() external payable {}

    fallback() external payable {}
}
