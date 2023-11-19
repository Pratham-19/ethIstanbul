// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {IERC721Receiver} from "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

import {IChronicle} from "lib/chronicle-std/src/IChronicle.sol";

/**
 * @title MarketPlace
 * @author Megabyte
 * @notice This contract is used to list and buy NFTs.
 * @notice
 */
contract MarketPlace is IERC721Receiver {
    struct Listing {
        address seller;
        uint256 price;
    }

    mapping(uint256 => Listing) public listings; // Maps tokenId to Listing

    IChronicle public immutable chronicle;
    IERC721 public immutable nftContract;
    IERC20 public immutable tokenContract;

    event ItemListed(address indexed seller, uint256 indexed tokenId, uint256 price);
    event ItemSold(address indexed buyer, uint256 indexed tokenId, uint256 price);

    constructor(address _nftContract, address _tokenAddress, address _chronicleAddresss) {
        nftContract = IERC721(_nftContract);
        tokenContract = IERC20(_tokenAddress);
        chronicle = IChronicle(_chronicleAddresss);
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

        delete listings[tokenId];

        tokenContract.transferFrom(msg.sender, listing.seller, 2 ether);
        nftContract.transferFrom(address(this), msg.sender, tokenId);

        emit ItemSold(msg.sender, tokenId, listing.price);
    }

    function buyItemWithETH(uint256 tokenId) external payable {
        Listing memory listing = listings[tokenId];

        delete listings[tokenId];

        uint256 totalPrice = getPriceInETH(tokenId);
        require(msg.value > totalPrice, "Incorrect price");

        (bool success,) = listing.seller.call{value: msg.value}("");
        require(success, "Transfer failed.");

        nftContract.transferFrom(address(this), msg.sender, tokenId);

        emit ItemSold(msg.sender, tokenId, listing.price);
    }

    function getPriceInETH(uint256 tokenId) public view returns (uint256 priceInETH) {
        Listing memory listing = listings[tokenId];

        priceInETH = ((listing.price * 1e18) / uint256(chronicle.read())) / 1e18;
    }

    function onERC721Received(address, address, uint256, bytes calldata) external pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
