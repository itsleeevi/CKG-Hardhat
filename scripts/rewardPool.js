require("dotenv").config();
const hre = require("hardhat");

async function main() {
  //const CKG = "0xa2ba0fedd30846876b601d9afc92c72f58f6aec0";
  //const SCS = "0xBA0B0A9e71f6c60cd87340A85e9D4f551d4Da3E5";
  const CKG = "0xa2ba0fedd30846876b601d9afc92c72f58f6aec0";
  const SCS = "0xBA0B0A9e71f6c60cd87340A85e9D4f551d4Da3E5";

  const RewardPool = await hre.ethers.getContractFactory("RewardPool");
  const rewardPool = await RewardPool.deploy(CKG, SCS);
  await rewardPool.deployTransaction.wait();
  console.log("rewardPool deployed to:", rewardPool.address);
  console.log(
    "npx hardhat verify --network bsc_test",
    rewardPool.address,
    CKG,
    SCS
  );
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
