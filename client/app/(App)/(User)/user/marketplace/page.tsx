import MarketplaceCard from "@/app/_components/Card/MarketPlaceCard";
import Footer from "@/app/_components/Footer";
import React from "react";
export default function Marketplace() {
  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <h1 className="text-4xl font-semibold text-center uppercase">
        MarketPlace
      </h1>
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
