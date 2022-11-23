// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721Pausable.sol";
import "@openzeppelin/contracts@4.6.0/utils/Counters.sol";
import "@openzeppelin/contracts@4.6.0/utils/Strings.sol";

contract PausableNFT is ERC721Pausable, ERC721URIStorage, Ownable {

    /**
     * @dev
     * - _tokenIds can use all functions of Counters
     */
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    /**
     * @dev
     * - record who sets what uri to what tokenId.
     */
    event TokenURIChanged(address indexed sender, uint256 indexed tokenId, string uri);

    constructor() ERC721("PausableNFT", "PAUSE") {}

    /**
     * @dev
     * - onlyOwner: only the address, which deployed this contract, can mint
     * - _tokenIds.increment(): increment tokenId
     * - _mint(): link tokenId to the address, which executes nftMint function
     * - _setTokenURI(): set uri at the time of mint
     * - trigger event
     */
    function nftMint() public onlyOwner whenNotPaused() {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _mint(_msgSender(), newTokenId);

        string memory jsonFile = string(abi.encodePacked('metadata', Strings.toString(newTokenId), '.json'));
        _setTokenURI(newTokenId, jsonFile);
        emit TokenURIChanged(_msgSender(), newTokenId, jsonFile);
    }

    /**
     * @dev
     * - set URI prefix
     */
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://bafybeigyod7ldrnytkzrw45gw2tjksdct6qaxnsc7jdihegpnk2kskpt7a/";
    }

    /**
     * @dev
     * - stop NFT
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev
     * - release stop NFT
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev
     * - override
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal override(ERC721, ERC721Pausable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    /**
     * @dev
     * - override
     */
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    /**
     * @dev
     * - override
     */
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

}