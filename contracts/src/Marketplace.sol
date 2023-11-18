// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

/**
 * @title MarketPlace
 * @author Megabyte
 * @notice This contract is used to list and buy NFTs.
 */
contract MarketPlace is IERC721Receiver {
    address public immutable i_NFTDropAddress;

    uint256 public constant MAX_PRICE = 5 ether;

    constructor(address _nftDropAddress) {
        i_NFTDropAddress = _nftDropAddress;
    }
    ////////////////////////////////////////////////////////////////
    ///////////////////////// external /////////////////////////////
    ////////////////////////////////////////////////////////////////

    /**
     * This function will list the component NFTs for sale.
     * @param _tokenId The tokenId of the NFT to be listed
     */
    function listItem(uint256 _tokenId) external {
        IERC721(i_NFTDropAddress).safeTransferFrom(msg.sender, address(this), _tokenId);
    }

    /**
     * This function will buy the component NFTs.
     * @param _tokenId The tokenId of the NFT to be sold
     */
    function buyItem(uint256 _tokenId) external payable {
        require(msg.value == MAX_PRICE, "MarketPlace: incorrect price");
        IERC721(i_NFTDropAddress).safeTransferFrom(address(this), msg.sender, _tokenId);
    }

    ////////////////////////////////////////////////////////////////
    ///////////////////////// functions required ///////////////////
    ////////////////////////////////////////////////////////////////
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data)
        external
        returns (bytes4)
    {}
}
