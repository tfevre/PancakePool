// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract MyToken is ERC20, Ownable, ERC20Burnable {
    address public teamAddress;
    address public liquidityPoolAddress;

    address[] private blacklist;
    event CustomTransferFnCalled();

    constructor(address _teamAddress, address _liquidityPoolAddress) ERC20("MyToken", "MTK") {
        mint(msg.sender, 10000);
        teamAddress = _teamAddress;
        liquidityPoolAddress = _liquidityPoolAddress;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function calculFees(uint256 _amount) internal returns (uint256[4] memory) {
        require(teamAddress != address(0) && teamAddress != address(0), "MyToken: Invalid addresses for the token Fees");
        // require(isBlacklisted(owner) == false && isBlacklisted(_to) == false, "MyToken: Blacklisted address");
        
        uint256 fees = SafeMath.div(SafeMath.sub(SafeMath.mul(_amount, 100), SafeMath.mul(_amount, 95)), 100);
        uint256 amountWithoutFees = SafeMath.sub(_amount, fees);
        uint256 teamFees = SafeMath.div(SafeMath.sub(SafeMath.mul(fees, 100), SafeMath.mul(fees, 60)), 100);
        uint256 burnFees = SafeMath.div(SafeMath.sub(SafeMath.mul(fees, 100), SafeMath.mul(fees, 80)), 100);

        emit CustomTransferFnCalled();
        return [amountWithoutFees, fees, teamFees, burnFees];
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool){
        require(from != address(0), "MyToken: transfer from the zero address");
        require(to != address(0), "MyToken: transfer to the zero address");

        uint256[4] memory Fees = calculFees(amount);

        _transfer(from, to, Fees[0]);

        _transfer(from, teamAddress, Fees[2]);
        _transfer(from, liquidityPoolAddress, Fees[2]);
        
        _burn(from, Fees[3]);
        return true;
    }

    



    function setLiquidityPoolAddress(address _ad) public onlyOwner {
        require(_ad != address(0), "invalid address");
        liquidityPoolAddress = _ad;
    }

    function setTeamAddress(address _ad) public onlyOwner {
        require(_ad != address(0), "invalid address");
        teamAddress = _ad;
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
