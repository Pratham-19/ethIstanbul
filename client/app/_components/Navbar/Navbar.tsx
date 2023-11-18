"use client";
import { useAccount } from "wagmi";
import { cn } from "../../_lib/utils";
import Image from "next/image";
import { useEffect } from "react";
import { useWeb3Modal } from "@web3modal/wagmi/react";

const Navbar = ({ className }: { className?: string }) => {
  const { address, isDisconnected } = useAccount();
  const { open } = useWeb3Modal();

  useEffect(() => {
    if (!address || isDisconnected) {
      open();
    }
  }, [address, isDisconnected]);
  return (
    <nav
      className={cn(
        "w-full bg-[hsl(var(--primary))] flex justify-between items-center h-16 rounded-[var(--radius)] px-3 py-5",
        className
      )}
    >
      <div className="flex space-x-2">
        <Image
          src="/logo.svg"
          alt="Navbar-logo"
          width={40}
          height={40}
          className="p-1 h-14"
        />
        <h2 className="font-extrabold my-auto uppercase text-xl">monalizard</h2>
      </div>

      <button
        className={
          "bg-white flex justify-between items-center rounded-xl space-x-3 py-2 px-2 border-b-4 border-black/[0.4] hover:translate-y-[3px] hover:border-none transition-transform duration-300"
        }
      >
        <div className="flex bg-black text-white justify-center items-center h-full px-3 py-1 rounded-[var(--radius)] space-x-2  ">
          <Image
            src="/bell-not.svg"
            alt="user"
            width={40}
            height={40}
            className="h-5 w-5"
          />
          <h2 className="text-md font-medium">23</h2>
        </div>
        {!address && (
          <button
            onClick={() => {
              open();
            }}
          >
            <h2>Connect Wallet</h2>
          </button>
        )}
        {address && (
          <button
            className="flex items-center justify-center"
            onClick={() => {
              open({ view: "Networks" });
            }}
          >
            <Image
              src="/nav-eth.svg"
              alt="user"
              width={40}
              height={40}
              className="h-6 w-6"
            />
            <h2>
              {address?.substring(0, 3)}...
              {address?.substring(address.length - 3)}
            </h2>
          </button>
        )}
      </button>
    </nav>
  );
};

export default Navbar;
