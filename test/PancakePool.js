const { expect } = require("chai");
const { ethers } = require('hardhat');

let MTK;
let MTK2;
let Pool;

describe('ERC20Stacking', function () {

  beforeEach(async function() {

    [owner, wallet1, team, liquidity] = await ethers.getSigners();


    const mtk = await ethers.getContractFactory('MyToken');
    const mtk2 = await ethers.getContractFactory('MyToken2');
    const pool = await ethers.getContractFactory('Pool');

    MTK = await mtk.deploy(team.address, liquidity.address);
    await MTK.deployed();
    
    MTK2 = await mtk2.deploy(team.address, liquidity.address);
    await MTK2.deployed();

    Pool = await pool.deploy(MTK.address, MTK2.address);
    await Pool.deployed();


    await MTK.approve(Pool.address, 10000);
    await MTK2.approve(Pool.address, 10000);
    MTK.setTeamAddress(team.address);
    MTK.setLiquidityPoolAddress(liquidity.address);
    // MTK2.setTeamAddress(team.address);
    // MTK2.setLiquidityPoolAddress(liquidity.address);
  });

  describe('deployment', function () {

    it('MTK : should mint tokens to owner', async function () {

      expect(await MTK.balanceOf(owner.address)).to.equal(10000);

    })

    it('MTK2 : should mint tokens to owner', async function () {

      expect(await MTK2.balanceOf(owner.address)).to.equal(10000);
  
    })

    it('Pool : should have approved tokens', async function () {

      expect(await MTK.allowance(owner.address, Pool.address)).to.equal(10000);
      expect(await MTK2.allowance(owner.address, Pool.address)).to.equal(10000);

    })
  })

  describe('Transfer', function () {

    it('MTK : should send token without fees', async function () {
      
      await MTK.transfer(wallet1.address, 100);

      expect(await MTK.balanceOf(owner.address)).to.equal(9900);
      expect(await MTK.balanceOf(wallet1.address)).to.equal(100);

    })

    it('MTK : should send token with fees', async function () {
      
      await Pool.connect(owner).safeTransferCall(MTK.address, wallet1.address, 100);

      expect(await MTK.balanceOf(owner.address)).to.equal(9900);
      expect(await MTK.balanceOf(wallet1.address)).to.equal(95);
      expect(await MTK.balanceOf(team.address)).to.equal(2);
      expect(await MTK.balanceOf(liquidity.address)).to.equal(2);
    })

  })
})