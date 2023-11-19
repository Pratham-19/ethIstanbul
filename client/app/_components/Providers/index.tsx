import React from "react";
import { Core } from "@walletconnect/core";
import { Web3Wallet } from "@walletconnect/web3wallet";

const core = new Core({
  projectId: process.env.NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID,
});

const Providers = async () => {
  const web3wallet = await Web3Wallet.init({
    core,
    metadata: {
      name: "Monalizard",
      description: "Play and promote",
      url: "",
      icons: [],
    },
  });
  return <div>Providers</div>;
};

export default Providers;
