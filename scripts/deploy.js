// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const Mtk2 = await hre.ethers.getContractFactory("MyToken2");
  const MTK2 = await Mtk2.deploy();
  await MTK2.deployed();

  const Mtk = await hre.ethers.getContractFactory("MyToken");
  const MTK = await Mtk.deploy();
  await MTK.deployed();

  const pool = await hre.ethers.getContractFactory("Pool");
  const POOL = await pool.deploy(MTK.address, MTK2.address);
  await POOL.deployed();
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
