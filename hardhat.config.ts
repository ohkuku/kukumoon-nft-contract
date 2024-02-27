import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    "optimism-sepolia": {
      url: "https://sepolia.optimism.io",
      accounts: [""]
    },
    "sepolia": {
      url: "https://rpc2.sepolia.org/",
      accounts: [""],
    },
    "optimism": {
      url: "https://mainnet.optimism.io",
      accounts: [""],
    },
  }
};

export default config;
