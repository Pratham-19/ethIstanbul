// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {RrpRequesterV0} from "@api3/contracts/rrp/requesters/RrpRequesterV0.sol";
import {AutomationCompatibleInterface} from "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

contract NFTDrop is ERC721, AutomationCompatibleInterface, RrpRequesterV0 {
    event NFTDrop__RequestedUint256Array(bytes32 indexed requestId, uint256 size);
    event NFTDrop__ReceivedUint256Array(bytes32 indexed requestId, uint256[] response);
    event NFTDrop__SetBaseURI(string baseURI);
    event NFTDrop__RequestQuantumon(address indexed user, bytes32 indexed requestId);
    event NFTDrop__GenerateQuantumon(address indexed user, uint256 indexed tokenId);

    using Counters for Counters.Counter;
    using Strings for uint256;

    uint256 public immutable i_interval;
    address public immutable i_airnodeAddress;
    address public immutable i_sponsorWallet;

    bytes32 public s_endpointIdUint256;
    uint256 public s_lastTimeStamp;
    uint256 public s_qrngUint256;
    uint256[9958] public s_ids; //Array to store the Quantomon Id - This is different from the tokenId

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
        address _sponsorWallet
    ) ERC721(name, symbol) RrpRequesterV0(_airnodeRrp) {
        i_interval = _interval;
        i_airnodeAddress = _airnodeAddress;
        i_sponsorWallet = _sponsorWallet;
        s_lastTimeStamp = block.timestamp;
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
            return string(abi.encodePacked(base, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(base, tokenId.toString()));
    }

    function _pickRandomUniqueId(uint256 random) private returns (uint256 id) {
        uint256 len = s_ids.length - _tokenIds.current();
        _tokenIds.increment();
        require(len > 0, "no s_ids left");
        uint256 randomIndex = random % len;
        id = s_ids[randomIndex] != 0 ? s_ids[randomIndex] : randomIndex;
        s_ids[randomIndex] = uint256(s_ids[len - 1] == 0 ? len - 1 : s_ids[len - 1]);
        s_ids[len - 1] = 0;
    }

    function requestQuantumon() public payable returns (bytes32) {
        require(msg.value >= 5 ether, "Need to send atleast 5 ether to the sponsorWallet");
        bytes32 requestId = airnodeRrp.makeFullRequest(
            i_airnodeAddress,
            s_endpointIdUint256,
            address(this),
            i_sponsorWallet,
            address(this),
            this.generateQuantumon.selector,
            ""
        );
        s_expectingRequestWithIdToBeFulfilled[requestId] = true;
        requestToSender[requestId] = msg.sender;
        (bool success,) = i_sponsorWallet.call{value: 0.01 ether}("");
        require(success, "Forward failed");
        emit NFTDrop__RequestQuantumon(msg.sender, requestId);
        return requestId;
    }

    function generateQuantumon(bytes32 requestId, bytes calldata data) public onlyAirnodeRrp {
        require(s_expectingRequestWithIdToBeFulfilled[requestId], "Request ID not known");
        s_expectingRequestWithIdToBeFulfilled[requestId] = false;
        uint256 qrngUint256 = abi.decode(data, (uint256));
        uint256 id = _pickRandomUniqueId(qrngUint256);
        uint256 tokenId = _tokenIds.current() - 1;
        _safeMint(requestToSender[requestId], tokenId);
        _setTokenURI(tokenId, id.toString());
        emit NFTDrop__GenerateQuantumon(requestToSender[requestId], tokenId);
    }

    function fuckingDropItRandomly() internal {}

    /////////////////////////
    /// API3 Functions ////
    /////////////////////////

    // /// @notice Requests a `uint256[]`
    // /// @param size Size of the requested array
    // function makeRequestUint256Array(uint256 size) external {
    //     bytes32 requestId = airnodeRrp.makeFullRequest(
    //         i_airnodeAddress,
    //         s_endpointIdUint256Array,
    //         address(this),
    //         i_sponsorWallet,
    //         address(this),
    //         this.fulfillUint256Array.selector,
    //         // Using Airnode ABI to encode the parameters
    //         abi.encode(bytes32("1u"), bytes32("size"), size)
    //     );
    //     s_expectingRequestWithIdToBeFulfilled[requestId] = true;
    //     emit NFTDrop__RequestedUint256Array(requestId, size);
    // }

    // /// @notice Called by the Airnode through the AirnodeRrp contract to
    // /// fulfill the request
    // function fulfillUint256Array(bytes32 requestId, bytes calldata data) external onlyAirnodeRrp {
    //     require(s_expectingRequestWithIdToBeFulfilled[requestId], "Request ID not known");
    //     s_expectingRequestWithIdToBeFulfilled[requestId] = false;
    //     uint256[] memory qrngUint256Array = abi.decode(data, (uint256[]));
    //     // Do what you want with `qrngUint256Array` here...
    //     s_qrngUint256Array = qrngUint256Array;
    //     emit NFTDrop__ReceivedUint256Array(requestId, qrngUint256Array);
    // }

    /////////////////////////
    /// Chainlink functions ////
    /////////////////////////
    function checkUpkeep(bytes calldata /* checkData */ )
        external
        view
        override
        returns (bool upkeepNeeded, bytes memory /* performData */ )
    {
        upkeepNeeded = (block.timestamp - s_lastTimeStamp) > i_interval;
        // We don't use the checkData in this example. The checkData is defined when the Upkeep was registered.
    }

    function performUpkeep(bytes calldata /* performData */ ) external override {
        if ((block.timestamp - s_lastTimeStamp) > i_interval) {
            s_lastTimeStamp = block.timestamp;
            // call the API3
        }
        // We don't use the performData in this example. The performData is generated by the Automation Node's call to your checkUpkeep function
    }

    function withdraw() external {
        airnodeRrp.requestWithdrawal(i_airnodeAddress, i_sponsorWallet);
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
