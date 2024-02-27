import { ethers } from "hardhat";
import {CONTRACT_ID} from "./contract";

async function main() {
    const contractAddress = CONTRACT_ID;
    const [owner] = await ethers.getSigners();

    const NFTContract = await ethers.getContractAt("Kukumoon", contractAddress, owner);

    const tx = await NFTContract.setNotRevealedURI("ipfs://Qmdcz1AWJyEgwF3WkLUUfACiMUwhFHc21ABNdfGoRHSXPE");
    await tx.wait();

    console.log("NFT reveal:", tx.hash);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
