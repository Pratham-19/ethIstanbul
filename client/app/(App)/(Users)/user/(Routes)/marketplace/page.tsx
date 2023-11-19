"use client";
import MarketplaceCard from "@/app/_components/Card/MarketPlaceCard";
import Footer from "@/app/_components/Footer";
import Image from "next/image";
import React from "react";
import {
  prepareWriteContract,
  waitForTransaction,
  writeContract,
} from "wagmi/actions";
import MarketPlace from "@/app/_abis/abi/MarketPlace.json";
import toast from "react-hot-toast";

export default function Marketplace() {
  const [token, setToken] = React.useState("");
  const [price, setPrice] = React.useState("");

  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <section className="flex justify-between px-2">
        <h1 className="text-4xl font-semibold text-center uppercase">
          MarketPlace
        </h1>
        <button className="bg-black rounded-xl flex justify-center items-center space-x-2 px-5 hover:scale-[0.97] transition-transform duration-300 relative group">
          <Image
            src="/list.svg"
            alt="add"
            width={40}
            height={40}
            className="w-6 h-6"
          />

          <h2 className="text-[#EFB359] font-medium">Sell Piece</h2>
          <div className="absolute translate-y-1/2 -translate-x-1/2 hidden group-hover:block transition-transform duration-300">
            <section className="bg-[#EFB359] font-semibold w-[16vw] px-1 py-2 rounded-t-xl">
              Selling Piece
            </section>
            <section className="bg-white/70 border-[#EFB359] border backdrop-blur-sm font-semibold w-[16vw] px-1 py-2 rounded-b-xl h-[30vh] space-y-4 pt-4">
              <section className="flex justify-between items-center">
                <h2 className="text-[#EFB359]">Piece</h2>
                <input
                  onChange={(e) => {
                    setToken(e.target.value);
                  }}
                  type="text"
                  className="border-[#EFB359] border-2 rounded-xl px-2 py-1 w-[10vw]"
                />
              </section>
              <section className="flex justify-between items-center">
                <h2 className="text-[#EFB359]">Price</h2>
                <input
                  onChange={(e) => {
                    setPrice(e.target.value);
                  }}
                  type="text"
                  className="border-[#EFB359] border-2 rounded-xl px-2 py-1 w-[10vw]"
                />
              </section>
              <button
                className="bg-black text-[#EFB359] font-semibold px-3 py-1 hover:scale-95 transition-transform duration-300 rounded-xl mt-2"
                onClick={async () => {
                  const { request } = await prepareWriteContract({
                    address: MarketPlace.address as `0x${string}`,
                    abi: MarketPlace.abi,
                    functionName: "listItem",
                    args: [token, price],
                  });
                  const { hash: uploadyERC } = await writeContract(request);
                  await waitForTransaction({ hash: uploadyERC })
                    .then(() => console.log("transaction confirmed"))
                    .catch((error) => {
                      toast.dismiss("uploading");
                      console.log("error", error);
                    });
                }}
              >
                List
              </button>
            </section>
          </div>
        </button>
      </section>
      <div className="flex flex-wrap gap-4 mt-5 mb-12">
        <MarketplaceCard img="/c1.jpg" />
        <MarketplaceCard img="/c2.jpg" />
        <MarketplaceCard img="/c3.jpg" />
        <MarketplaceCard img="/c4.jpg" />
        <MarketplaceCard img="/chicken-glasses.jpg" />
      </div>
      <Footer className="" />
    </div>
  );
}
