// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "contracts/MyToken.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

contract Pool is Ownable{
    MyToken public ERC20Token;
    address public poolAddress;
  
    address public token2Address = 0x094616F0BdFB0b526bD735Bf66Eca0Ad254ca81F;
    address public constant ERC20TokenAddress = 0x9Edc5ec1Ec2ceF63df9696f9483a8f24Fa284035;
    address public constant routerAddress = 0xD99D1c33F9fC3444f8101754aBC46c52416550D1;
    address public constant factoryAddress = 0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73;
    IUniswapV2Router02 private pancakeRouter = IUniswapV2Router02(routerAddress);
    IUniswapV2Factory private factory = IUniswapV2Factory(factoryAddress);
    address[] private blacklist;


    constructor() {
        ERC20Token = MyToken(ERC20TokenAddress);
        //ERC20Token.mint(address(this), 1000);
        ERC20Token.approve(routerAddress, 1000);
    }
    
    function createPair() public onlyOwner {
        poolAddress = factory.createPair(ERC20TokenAddress, token2Address);
    }

    function changeToken2(address _address) public onlyOwner{
        require(_address != address(0), "invalid address");
        token2Address = _address;
    }

    function addBlacklist(address _ad) public onlyOwner {
        blacklist.push(_ad);
    }

    function removeBlacklist(address _ad) public onlyOwner {
        address[] memory tmpBlacklist = blacklist;
        blacklist = new address[](0); // Reset the blacklist

        for (uint i = 0; i < tmpBlacklist.length; i++){
            if(tmpBlacklist[i] != _ad){
                blacklist.push(tmpBlacklist[i]);
            } 
        }
    }

    function isBlacklisted(address _ad) public view returns(bool){
        for (uint i = 0; i < blacklist.length; i++){
            if(blacklist[i] == _ad){
                return true;
            } 
        }
        return false;
    }
}