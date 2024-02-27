import { ethers } from "hardhat";
import {CONTRACT_ID} from "./contract";

async function main() {
    const contractAddress = CONTRACT_ID;
    const [owner] = await ethers.getSigners();

    const NFTContract = await ethers.getContractAt("Kukumoon", contractAddress, owner);

    const tx = await NFTContract.mintNFT(10);
    await tx.wait();

    console.log("NFT minted:", tx.hash);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
