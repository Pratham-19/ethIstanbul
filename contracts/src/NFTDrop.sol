// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import {RrpRequesterV0} from "@api3/contracts/rrp/requesters/RrpRequesterV0.sol";

contract NFTDrop is ERC721, RrpRequesterV0 {
    event NFTDrop__RequestedUint256(bytes32 indexed requestId);
    event NFTDrop__ReceivedUint256(bytes32 indexed requestId, uint256 indexed response);
    event NFTDrop__SetBaseURI(string baseURI);
    event NFTDrop__RequestQuantumon(address indexed user, bytes32 indexed requestId);
    event NFTDrop__GenerateQuantumon(address indexed user, uint256 indexed tokenId);
    event NFTDrop__SetSponsorWallet(address indexed sponsorWallet);

    using Counters for Counters.Counter;
    using Strings for uint256;

    uint256 constant MIN_RANGE = 0;
    uint256 constant MAX_RANGE = 10;
    uint256 public immutable i_interval;
    address public immutable i_airnodeAddress;

    address public s_sponsorWallet;
    bytes32 public s_endpointIdUint256;
    uint256 public s_lastTimeStamp;
    uint256 public s_qrngUint256;
    uint256[9958] public s_ids; //Array to store the Quantomon Id - This is different from the tokenId
    address[] public s_users = [
        0xa60f738a60BCA515Ac529b7335EC7CB2eE3891d2,
        0xdDCc06f98A7C71Ab602b8247d540dA5BD8f5D2A2,
        0x566771D19FD088eE190e37C38d530a71453A5A31,
        0xbd394F796af6dBF94896D7F0e43524b53F32199d
    ];

    // Mapping that maps the requestId for a random number to the fullfillment status of that request
    mapping(bytes32 => bool) public s_expectingRequestWithIdToBeFulfilled;
    //Mapping that maps the requestId to the address that made the request
    mapping(bytes32 => address) requestToSender;

    Counters.Counter private _tokenIds;
    string private _baseURIextended; // The Extended baseUrl for ERC721
    mapping(uint256 => string) private s_tokenURIs; //Mapping a custom URI to a tokenId

    constructor(
        string memory name,
        string memory symbol,
        uint256 _interval,
        address _airnodeRrp,
        address _airnodeAddress,
        bytes32 _endpointIdUint256
    ) ERC721(name, symbol) RrpRequesterV0(_airnodeRrp) {
        i_interval = _interval;
        i_airnodeAddress = _airnodeAddress;
        s_lastTimeStamp = block.timestamp;
        s_endpointIdUint256 = _endpointIdUint256;
    }

    function setSponsorWallet(address _sponsorWallet) external {
        s_sponsorWallet = _sponsorWallet;
        emit NFTDrop__SetSponsorWallet(_sponsorWallet);
    }

    function setBaseURI(string memory baseURI) external {
        _baseURIextended = baseURI;
        emit NFTDrop__SetBaseURI(_baseURIextended);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory _tokenURI = s_tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI, ".json"));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(base, tokenId.toString(), ".json"));
    }

    function fuckingDropItRandomly() public {
        uint256 addressLength = s_users.length;
        uint256 i;
        for (i = 0; i < addressLength;) {
            requestQuantumon(s_users[i]);
            unchecked {
                i++;
            }
        }
    }

    function mintTaskCompletionNFT(address _user) external {
        requestQuantumon(_user);
    }

    /////////////////////////
    /// API3 Functions ////
    /////////////////////////

    function requestQuantumon(address _user) public returns (bytes32) {
        bytes32 requestId = airnodeRrp.makeFullRequest(
            i_airnodeAddress,
            s_endpointIdUint256,
            address(this),
            s_sponsorWallet,
            address(this),
            this.generateQuantumon.selector,
            ""
        );
        s_expectingRequestWithIdToBeFulfilled[requestId] = true;
        requestToSender[requestId] = _user;
        emit NFTDrop__RequestQuantumon(_user, requestId);
        return requestId;
    }

    function generateQuantumon(bytes32 requestId, bytes calldata data) public onlyAirnodeRrp {
        require(s_expectingRequestWithIdToBeFulfilled[requestId], "Request ID not known");
        s_expectingRequestWithIdToBeFulfilled[requestId] = false;
        uint256 qrngUint256 = abi.decode(data, (uint256));
        uint256 randomNumber = (qrngUint256 % (MAX_RANGE - MIN_RANGE + 1)) + MIN_RANGE;
        uint256 id = _pickRandomUniqueId(randomNumber);
        uint256 tokenId = _tokenIds.current() - 1;
        _safeMint(requestToSender[requestId], tokenId);
        _setTokenURI(tokenId, id.toString());
        emit NFTDrop__GenerateQuantumon(requestToSender[requestId], tokenId);
    }

    function withdraw() external {
        airnodeRrp.requestWithdrawal(i_airnodeAddress, s_sponsorWallet);
    }

    ///////////////////////////
    // internal functions /////
    ///////////////////////////

    function _pickRandomUniqueId(uint256 random) internal returns (uint256 id) {
        uint256 len = s_ids.length - _tokenIds.current();
        _tokenIds.increment();
        require(len > 0, "no s_ids left");
        uint256 randomIndex = random % len;
        id = s_ids[randomIndex] != 0 ? s_ids[randomIndex] : randomIndex;
        s_ids[randomIndex] = uint256(s_ids[len - 1] == 0 ? len - 1 : s_ids[len - 1]);
        s_ids[len - 1] = 0;
    }

    ///////////////////////////
    // override functions /////
    ///////////////////////////

    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721Metadata: URI set of nonexistent token");
        s_tokenURIs[tokenId] = _tokenURI;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseURIextended;
    }
}
