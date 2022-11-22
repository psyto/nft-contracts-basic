// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";

contract OnlyOwnerMint is ERC721 {

    /**
     * @dev
     * - owner is an address, which deployed this contract.
     */
    address public owner;

    constructor() ERC721("OnlyOwnerMint", "OWNER") {
        owner = _msgSender();
    }

    /**
     * @dev
     * - only the address, which deployed this contract, can mint.
     */
    function nftMint(uint256 tokenId) public {
        require(owner == _msgSender(), "Caller is not the owner.");
        _mint(_msgSender(), tokenId);
    }
}