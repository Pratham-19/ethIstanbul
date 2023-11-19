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

const projectId = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJkaWQ6ZXRocjoweDgyYzA4ZjM0OTlkOTgwNGNhOTMxNjVjYzAwRDVBMDI3YjczOTU1MjciLCJpc3MiOJ3ZWIzLXN0b3JhZ2UiLCJpYXQiOjE2ODI4NDQ2MjQxODAsIm5hbWUiOiJodWRkbGVodWIifQ.o3Ly1ifgCW2yVsTtmxl7JzyXyyx8GJJsKvwmvAK0QMY"

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
