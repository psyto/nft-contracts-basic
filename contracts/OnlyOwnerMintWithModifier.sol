// SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

import "@openzeppelin/contracts@4.6.0/token/ERC721/ERC721.sol";

contract OnlyOwnerMintWithModifier is ERC721 {

    /**
     * @dev
     * - owner is an address, which deployed this contract.
     */
    address public owner;

    constructor() ERC721("OnlyOwnerMintWithModifier", "OWNERMOD") {
        owner = _msgSender();
    }

    /**
     * @dev
     * - modifier to accept only the address, which deployed this contract.
     */
    modifier onlyOwner {
        require(owner == _msgSender(), "Caller is not the owner.");
        _;
    }

    /**
     * @dev
     * - only the address, which deployed this contract, can mint.
     * - link tokenId to the address, which executes nftMint function.
     */
    function nftMint(uint256 tokenId) public onlyOwner {

        _mint(_msgSender(), tokenId);
    }
}