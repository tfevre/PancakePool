const { expect } = require("chai");
const { ethers } = require('hardhat');

let MTK;
let MTK2;

describe('ERC20Stacking', function () {

  beforeEach(async function() {

    [owner, wallet1, wallet2] = await ethers.getSigners();


    const mtk = await ethers.getContractFactory('MyToken');
    const mtk2 = await ethers.getContractFactory('MyToken2');

    MTK = await mtk.deploy();
    await MTK.deployed();
    
    MTK2 = await mtk2.deploy();
    await MTK2.deployed();
    
    // MTK.connect(wallet1).mint(wallet2.address, 100);
    // MTK.connect(wallet1).mint(wallet1.address, 5000);
    // MTK.transfer(wallet2.address, 1000);

    // MTK.connect(owner).mint(owner.address, 100);
    // console.log(await MTK.owner(), " ", owner.address);

    // await MTK.connect(wallet1).approve(Stacking.address, 4000);
    // await MTK.connect(wallet2).approve(Stacking.address, 1000);
  });

  describe('deployment', function () {

    it('MTK : should mint tokens to owner', async function () {

      expect(await MTK.balanceOf(owner.address)).to.equal(ethers.BigNumber.from("1000000000000000000000"));

    })


    it('MTK2 : should mint tokens to owner', async function () {

        expect(await MTK2.balanceOf(owner.address)).to.equal(ethers.BigNumber.from("1000000000000000000000"));
  
      })
  })


})