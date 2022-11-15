// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyToken2 is ERC20, Ownable {

    constructor() ERC20("MyToken2", "MTK2") {
        mint(msg.sender, 10000);
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

}

