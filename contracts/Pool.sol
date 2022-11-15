// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "contracts/MyToken.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

contract Pool is Ownable{
    MyToken public ERC20Token;
    ERC20 public ERC20Token2;

    address public constant routerAddress = 0xD99D1c33F9fC3444f8101754aBC46c52416550D1;
    IUniswapV2Router02 private pancakeRouter = IUniswapV2Router02(routerAddress);
    IUniswapV2Factory private factory = IUniswapV2Factory(pancakeRouter.factory());

    constructor(address _token1, address _token2) {
        ERC20Token = MyToken(_token1);
        ERC20Token2 = ERC20(_token2);
    }

    function safeTransferCall(address _token, address _to, uint256 _value) public onlyOwner {
        require(_value > 0, 'Pool: INSUFFICIENT_OUTPUT_AMOUNT');
        require(_to != address(0), 'Pool: Invalid address');

        MyToken(_token).transferFrom(msg.sender, _to, _value);
    }


    function createPair() public onlyOwner {
        if (factory.getPair(address(ERC20Token), address(ERC20Token2)) == address(0)){
            factory.createPair(address(ERC20Token), address(ERC20Token2));
        }
    }

    function changeTokenAddress(address _address) public onlyOwner{
        require(_address != address(0), "invalid address");
        
        if (factory.getPair(_address, address(ERC20Token2)) == address(0)){
            factory.createPair(_address, address(ERC20Token2));
        }
    }

    function changeToken2Address(address _address) public onlyOwner{
        require(_address != address(0), "invalid address");

        if (factory.getPair(address(ERC20Token), _address) == address(0)){
            factory.createPair(address(ERC20Token), _address);
        }
    }

}