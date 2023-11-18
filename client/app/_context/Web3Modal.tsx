"use client";
import { createWeb3Modal, defaultWagmiConfig } from "@web3modal/wagmi/react";

import { WagmiConfig } from "wagmi";
import {
  arbitrumGoerli,
  baseGoerli,
  celoAlfajores,
  chiliz,
  gnosis,
  lineaTestnet,
  mantaTestnet,
  neonDevnet,
  polygonZkEvmTestnet,
  polygonMumbai,
  scrollSepolia,
  xdcTestnet,
} from "viem/chains";
import { useEffect, useState } from "react";

const projectId = process.env.NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID ?? "";

const metadata = {
  name: "Monalizard",
  description: "play and promote",
  url: "https://web3modal.com",
  icons: ["https://avatars.githubusercontent.com/u/37784886"],
};

const chains = [
  baseGoerli,
  arbitrumGoerli,
  celoAlfajores,
  chiliz,
  gnosis,
  lineaTestnet,
  mantaTestnet,
  neonDevnet,
  polygonZkEvmTestnet,
  polygonMumbai,
  scrollSepolia,
  xdcTestnet,
];
const wagmiConfig = defaultWagmiConfig({ chains, projectId, metadata });

createWeb3Modal({ wagmiConfig, projectId, chains });

export function Web3Modal({ children }: { children: React.ReactNode }) {
  const [ready, setReady] = useState(false);

  useEffect(() => {
    setReady(true);
  }, []);
  if (!ready) return null;
  return <WagmiConfig config={wagmiConfig}>{children}</WagmiConfig>;
}
