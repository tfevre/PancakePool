// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "contracts/MyToken.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol";

contract Pool is Ownable{
    MyToken public ERC20Token;
    ERC20 public ERC20Token2;
    address public poolAddress;

    bytes4 private constant SELECTOR = bytes4(keccak256(bytes('transfer(address,uint256)')));

    constructor(address _token1, address _token2) {
        ERC20Token = MyToken(_token1);
        ERC20Token2 = ERC20(_token2);
    }

    function safeTransferCall(address _token, address _to, uint256 _value) public onlyOwner {
        require(_value > 0, 'Pool: INSUFFICIENT_OUTPUT_AMOUNT');
        require(_to != address(0), 'Pool: Invalid address');

        MyToken(_token).transferFrom(msg.sender, _to, _value);
    }


    // function createPair() public onlyOwner {
    //     if (factory.getPair(ERC20TokenAddress, ERC20Token2Address) == address(0)){
    //         poolAddress = factory.createPair(ERC20TokenAddress, ERC20Token2Address);
    //     }
    // }

}