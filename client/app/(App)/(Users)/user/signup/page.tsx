"use client";
import React, { useEffect } from "react";
import Image from "next/image";
import { useWeb3Modal } from "@web3modal/wagmi/react";
import { useAccount } from "wagmi";
import Link from "next/link";
import prisma from "@/prisma";

const Signup = () => {
  const { open } = useWeb3Modal();
  const { address, isDisconnected } = useAccount();

  useEffect(() => {
    console.log("address", address);
    if (!address || isDisconnected) {
      open();
    }
  }, [address, isDisconnected]);

  return (
    <div className="w-screen h-screen flex">
      <div className="w-[57vw] flex flex-col justify-center items-center">
        <div className="flex space-x-2 my-4">
          <Image
            src="/logo.svg"
            alt="Navbar-logo"
            width={40}
            height={40}
            className="h-24 w-24"
          />
          <h2 className="font-extrabold my-auto uppercase text-3xl">
            monalizard
          </h2>
        </div>
        <h2 className="text-xl my-4">Prove your humanity</h2>
        <section className="flex flex-col space-y-4 mt-7">
          <Link
            href="/api/auth/login"
            className="flex justify-center items-center space-x-2 hover:scale-[0.95] transition-transform duration-300 px-20 py-6 rounded-3xl shadow-lg border border-black"
          >
            <Image
              src="/worldcoin.svg"
              alt="signup"
              width={40}
              height={40}
              className="h-6 w-6"
            />
            <h2>WorldCoin</h2>
          </Link>
          <Link
            href="/"
            className="flex justify-center items-center space-x-2 hover:scale-[0.95] transition-transform duration-300 px-20 py-6 rounded-3xl shadow-lg border border-black"
          >
            <Image
              src="/lens.svg"
              alt="signup"
              width={40}
              height={40}
              className="h-6 w-6"
            />
            <h2>Lens</h2>
          </Link>
        </section>
      </div>
      <div className="w-[43vw] flex justify-end">
        <Image
          src={"/signup-pic.jpg"}
          alt="signup"
          width={600}
          height={1024}
          className="h-screen aspect-auto"
        />
      </div>
    </div>
  );
};

export default Signup;
