import CharacterCard from "@/app/_components/Card/CharacterCard";
import PieceCard from "@/app/_components/Card/PieceCard";
import Footer from "@/app/_components/Footer";
import Image from "next/image";
import React from "react";

export default function Dashboard() {
  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <h1 className="text-4xl font-semibold text-center uppercase">
        DashBoard
      </h1>

      <h2 className="text-2xl font-semibold">Characters Collected</h2>
      <div className="my-5">
        <CharacterCard />
      </div>
      <section className="flex justify-between">
        <h2 className="text-2xl font-semibold">Piece Minted</h2>
        <div className="bg-black text-[#EFB359] space-x-2 px-3 py-2 rounded-xl flex justify-center items-center">
          <Image
            src="/timer.svg"
            alt="chat-pic"
            width={40}
            height={40}
            className="w-6 h-6"
          />
          <h2>Next Airdrop</h2>
          <h2>00:05:00</h2>
        </div>
      </section>
      <div className="my-5">
        <PieceCard />
      </div>
      <Footer />
    </div>
  );
}
