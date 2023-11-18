// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {ERC6551Registry} from "@erc6551/contracts/ERC6551Registry.sol";

contract QuestNFT is ERC721, ERC721URIStorage {
    event QuestNFT__Minted(address indexed user, uint256 indexed tokenId, address indexed tba);
    event QuestNFT__MintedQuestCompletionNFT(address indexed user, uint256 indexed tokenId);

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIds;

    address immutable i_registryAddress;
    address immutable i_implementationAddress;
    uint256 immutable i_chainId;
    string public s_uri;

    mapping(uint256 => address) public tokenToTBA;

    constructor(address _registryAddress, address _implementationAddress, uint256 _chainId, string memory _uri)
        ERC721("QuestNFT", "QST")
    {
        i_registryAddress = _registryAddress;
        i_implementationAddress = _implementationAddress;
        i_chainId = _chainId;
        s_uri = _uri;
    }

    function mint(address user) external returns (uint256, address) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _safeMint(user, newItemId);
        _setTokenURI(newItemId, s_uri);
        address tba = createTBA(keccak256(abi.encodePacked(user, newItemId)), newItemId);
        tokenToTBA[newItemId] = tba;

        emit QuestNFT__Minted(user, newItemId, tba);

        return (newItemId, tba);
    }

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

    function getTBA(uint256 tokenId) public view returns (address) {
        return tokenToTBA[tokenId];
    }

    // override functions from ERC721 and ERC721URIStorage

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
}
