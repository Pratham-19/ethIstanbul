import MarketplaceCard from "@/app/_components/Card/MarketPlaceCard";
import Footer from "@/app/_components/Footer";
import Image from "next/image";
import React from "react";
export default function Marketplace() {
  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <section className="flex justify-between px-2">
        <h1 className="text-4xl font-semibold text-center uppercase">
          MarketPlace
        </h1>
        <button className="bg-black rounded-xl flex justify-center items-center space-x-2 px-5 hover:scale-[0.97] transition-transform duration-300">
          <Image
            src="/list.svg"
            alt="add"
            width={40}
            height={40}
            className="w-6 h-6"
          />
          <h2 className="text-[#EFB359] font-medium">Sell Piece</h2>
        </button>
      </section>
      <div className="flex flex-wrap gap-4 mt-5 mb-12">
        <MarketplaceCard />
        <MarketplaceCard />
        <MarketplaceCard />
        <MarketplaceCard />
        <MarketplaceCard />
        <MarketplaceCard />
      </div>
      <Footer className="" />
    </div>
  );
}
