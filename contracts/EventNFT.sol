// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.6.0/token/ERC721/extensions/ERC721URIStorage.sol";

contract EventNFT is ERC721URIStorage, Ownable {

    /**
     * @dev
     * - record who sets what uri to what tokenId.
     */
    event TokenURIChanged(address indexed sender, uint256 indexed tokenId, string uri);

    constructor() ERC721("EventNFT", "EVENT") {}

    /**
     * @dev
     * - only the address, which deployed this contract, can mint.
     * - link tokenId to the address, which executes nftMint function.
     * - set uri at the time of mint.
     * - trigger event
     */
    function nftMint(uint256 tokenId, string calldata uri) public onlyOwner {
        _mint(_msgSender(), tokenId);
        _setTokenURI(tokenId, uri);
        emit TokenURIChanged(_msgSender(), tokenId, uri);
    }
}