// Contract based on https://docs.openzeppelin.com/contracts/3.x/erc721
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Kukumoon is ERC721Enumerable, Ownable {
    using Strings for uint256;

    bool public _revealed = true;
    bool public _available = true;
    bool public _isSpecialEvent = false;

    uint256 public constant MAX_SUPPLY = 32;
    uint256 public maxMint = 32;

    string baseURI;
    string public notRevealedURI;
    string public specialEventURI;
    string public baseExtension = ".json";

    mapping(uint256 => string) private _tokenURIs;

    constructor(string memory initBaseURI, string memory initNotRevealedURI, string memory initSpecialEventURI)
    ERC721("Kukumoon", "KMN") Ownable(msg.sender)
    {
        setBaseURI(initBaseURI);
        setNotRevealedURI(initNotRevealedURI);
        setSpecialEventURI(initSpecialEventURI);
    }

    function mintNFT(uint256 tokenQuantity) public onlyOwner {
        require(
            totalSupply() + tokenQuantity <= MAX_SUPPLY,
            "Sale would exceed max supply"
        );
        require(_available, "Kukumoon NFT is preparing now");
        require(tokenQuantity <= maxMint, "Don't mint that much dude!");
        _mintNFT(tokenQuantity);
    }

    function _mintNFT(uint256 tokenQuantity) internal {
        for (uint256 i = 0; i < tokenQuantity; i++) {
            uint256 mintIndex = totalSupply();
            if (totalSupply() < MAX_SUPPLY) {
                _safeMint(msg.sender, mintIndex);
            }
        }
    }

    function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
    {
        require(
            _ownerOf(tokenId) != address(0),
            "ERC721Metadata: URI query for nonexistent token"
        );

        if (_revealed == false) {
            return notRevealedURI;
        }

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _isSpecialEvent ? specialEventURI : _baseURI();

    if (bytes(base).length == 0) {
            return _tokenURI;
        }

        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return
            string(abi.encodePacked(base, tokenId.toString(), baseExtension));
    }
    
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }
    
    function toggleAvailability() public onlyOwner {
        _available = !_available;
    }

    function toggleReveal() public onlyOwner {
        _revealed = !_revealed;
    }

    function toggleIsSpecialEvent() public onlyOwner {
        _isSpecialEvent = !_isSpecialEvent;
    }

    function setNotRevealedURI(string memory _notRevealedURI) public onlyOwner {
        notRevealedURI = _notRevealedURI;
    }

    function setSpecialEventURI(string memory _specialEventURI) public onlyOwner {
        specialEventURI = _specialEventURI;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension)
    public
    onlyOwner
    {
        baseExtension = _newBaseExtension;
    }

    function setMaxMint(uint256 _maxMint) public onlyOwner {
        maxMint = _maxMint;
    }
}
