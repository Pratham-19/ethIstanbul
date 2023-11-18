// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title MarketPlace
 * @author Megabyte
 * @notice This contract is used to list and buy NFTs.
 * @notice
 */
contract MarketPlace {
    struct Listing {
        address seller;
        uint256 price;
    }

    mapping(uint256 => Listing) public listings; // Maps tokenId to Listing
    IERC721 public immutable nftContract;
    IERC20 public immutable tokenContract;

    event ItemListed(address indexed seller, uint256 indexed tokenId, uint256 price);
    event ItemSold(address indexed buyer, uint256 indexed tokenId, uint256 price);

    constructor(address _nftContract, address _tokenAddress) {
        nftContract = IERC721(_nftContract);
        tokenContract = IERC20(_tokenAddress);
    }

    function listItem(uint256 tokenId, uint256 price) external {
        require(nftContract.ownerOf(tokenId) == msg.sender, "Not the owner");
        require(price > 0, "Price must be greater than zero");

        nftContract.transferFrom(msg.sender, address(this), tokenId);
        listings[tokenId] = Listing(msg.sender, price);

        emit ItemListed(msg.sender, tokenId, price);
    }

    function buyItem(uint256 tokenId) external payable {
        Listing memory listing = listings[tokenId];

        require(tokenContract.balanceOf(msg.sender) >= listing.price, "Insufficient funds");

        delete listings[tokenId];

        tokenContract.transferFrom(msg.sender, listing.seller, listing.price);
        nftContract.transferFrom(address(this), msg.sender, tokenId);

        emit ItemSold(msg.sender, tokenId, listing.price);
    }
}
