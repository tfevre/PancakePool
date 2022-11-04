// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "contracts/MyToken.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";

contract Pool is Ownable{
    MyToken public ERC20Token;
    address constant ERC20TokenAddress = 0xD99D1c33F9fC3444f8101754aBC46c52416550D1;
    address constant routerAddress = 0xD99D1c33F9fC3444f8101754aBC46c52416550D1;
    IUniswapV2Router02 pancakeRouter = IUniswapV2Router02(routerAddress);
    address[] public blacklist;

    constructor() {
        ERC20Token.mint(address(this), 1000);
        ERC20Token.approve(routerAddress, 1000);
    }

    function CreatePair(address _tokenAddress) public onlyOwner{

    }
    

    function AddBlacklist(address _ad) public onlyOwner {
        blacklist.push(_ad);
    }

    function RemoveBlacklist(address _ad) public onlyOwner {
        address[] memory tmpBlacklist = blacklist;
        blacklist = new address[](0); // Reset the blacklist

        for (uint i = 0; i < tmpBlacklist.length; i++){
            if(tmpBlacklist[i] != _ad){
                blacklist.push(tmpBlacklist[i]);
            } 
        }
    }
}