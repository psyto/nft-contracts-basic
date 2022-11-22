// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";

contract OnlyOwnerMint is ERC721 {

    constructor() ERC721("OnlyOwnerMint", "OWNER") {}

    function nftMint(address to, uint256 tokenId) public {
        _mint(to, tokenId);
    }
}