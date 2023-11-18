// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

import {ERC6551Registry} from "@erc6551/contracts/ERC6551Registry.sol";

/**
 * @title QuestNFT
 * @author Megabyte
 * @notice This contract is used to mint Quest NFTs and create TBAs for each NFT.
 */
contract QuestNFT is ERC721, ERC721URIStorage {
    event QuestNFT__Minted(address indexed user, uint256 indexed tokenId, address indexed tba);
    event QuestNFT__MintedQuestCompletionNFT(address indexed user, uint256 indexed tokenId);

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    address immutable i_registryAddress;
    address immutable i_implementationAddress;
    uint256 immutable i_chainId;

    string private s_uri;
    mapping(uint256 => address) private tokenToTBA;

    constructor(address _registryAddress, address _implementationAddress, uint256 _chainId, string memory _uri)
        ERC721("QuestNFT", "QST")
    {
        i_registryAddress = _registryAddress;
        i_implementationAddress = _implementationAddress;
        i_chainId = _chainId;
        s_uri = _uri;
    }

    ////////////////
    // external /////
    ////////////////

    /**
     * This function is called by the Protocol Users to create a quest, mint quest NFT and create a TBA for the NFT.
     * @param _user Protocol Address
     * @return tokenId  The tokenId of the minted NFT
     * @return tbaAddress The TBA address of the minted NFT
     */
    function mintQuestNFT(address _user) external returns (uint256 tokenId, address tbaAddress) {
        _tokenIds.increment();
        tokenId = _tokenIds.current();
        _safeMint(_user, tokenId);
        _setTokenURI(tokenId, s_uri);
        tbaAddress = createTBA(keccak256(abi.encodePacked(_user, tokenId)), tokenId);
        tokenToTBA[tokenId] = tbaAddress;

        emit QuestNFT__Minted(_user, tokenId, tbaAddress);
    }

    /**
     * This function is called by the dApp users after they complete the quest to mint a quest completion NFT.
     * @param _user User Address
     */
    function mintQuestCompletionNFT(address _user) external {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(_user, newItemId);
        _setTokenURI(newItemId, s_uri);

        emit QuestNFT__MintedQuestCompletionNFT(_user, newItemId);
    }

    function createTBA(bytes32 salt, uint256 tokenId) internal returns (address) {
        address tokenContract = address(this);
        address tba = ERC6551Registry(i_registryAddress).createAccount(
            i_implementationAddress, salt, i_chainId, tokenContract, tokenId
        );

        return tba;
    }

    ////////////////
    // getters /////
    ////////////////
    function getURI() public view returns (string memory) {
        return s_uri;
    }

    function getTBA(uint256 tokenId) public view returns (address) {
        return tokenToTBA[tokenId];
    }

    ////////////////////////////////////////////////////////////////
    // override functions from ERC721 and ERC721URIStorage //////////
    ////////////////////////////////////////////////////////////////

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
