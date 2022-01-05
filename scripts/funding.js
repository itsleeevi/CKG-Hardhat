require("dotenv").config();
const hre = require("hardhat");

async function main() {
  const Funding = await hre.ethers.getContractFactory("Funding");
  const funding = await Funding.deploy();
  await funding.deployTransaction.wait();
  console.log("funding deployed to:", funding.address);
  console.log("npx hardhat verify --network bsc_test", funding.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
