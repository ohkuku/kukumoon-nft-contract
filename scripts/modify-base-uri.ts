import { ethers } from "hardhat";
import {CONTRACT_ID} from "./contract";

async function main() {
    const contractAddress = CONTRACT_ID;
    const [owner] = await ethers.getSigners();

    const NFTContract = await ethers.getContractAt("Kukumoon", contractAddress, owner);

    const tx = await NFTContract.setBaseURI("ipfs://QmarhR48qyuiLCXzfCgdPrvE6NBLJwwhvGSKuTVtZXqmJS/");
    await tx.wait();

    console.dir(tx, {depth: 4})

    console.log("NFT base changed:", tx.hash);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
