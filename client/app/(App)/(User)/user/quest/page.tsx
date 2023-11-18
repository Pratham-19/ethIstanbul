import QuestCard from "@/app/_components/Card/QuestCard";
import Footer from "@/app/_components/Footer";
import React from "react";

export default function Quest() {
  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <h1 className="text-4xl font-semibold text-center uppercase">Quests</h1>
      <div className=" my-7 space-y-8">
        <QuestCard />
        <QuestCard />
        <QuestCard />
        <QuestCard />
        <QuestCard />
      </div>
      <Footer className="" />
    </div>
  );
}
