import { ethers } from "hardhat";

async function main() {
  const KukuMoonNFT = await ethers.deployContract("Kukumoon", [
      "ipfs://QmarhR48qyuiLCXzfCgdPrvE6NBLJwwhvGSKuTVtZXqmJS/",
      "ipfs://Qmdcz1AWJyEgwF3WkLUUfACiMUwhFHc21ABNdfGoRHSXPE",
      "undefined",
  ]);
  await KukuMoonNFT.waitForDeployment();

  console.log("Contract deployed to:", KukuMoonNFT.target);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
