// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.6.0/access/Ownable.sol";

contract OZOnlyOwnerMint is ERC721, Ownable {

    constructor() ERC721("OZOnlyOwnerMint", "OZNER") {}

    /**
     * @dev
     * - only the address, which deployed this contract, can mint.
     * - link tokenId to the address, which executes nftMint function.
     */
    function nftMint(uint256 tokenId) public onlyOwner {
        _mint(_msgSender(), tokenId);
    }
}