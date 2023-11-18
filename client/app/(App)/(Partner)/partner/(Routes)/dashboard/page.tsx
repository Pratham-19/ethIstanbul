import Footer from "@/app/_components/Footer";
import React from "react";
import { PartnerDashboardQuest, QuestStatus } from "@/app/_lib/types";
import PartnerQuestCard from "@/app/_components/Card/PartnerQuestCard";

export default function Dashboard() {
  const quests: PartnerDashboardQuest[] = [
    {
      img: "/quest-hen.png",
      title: "EL Pollo Loco",
      timer: "00:05:00",
      participants: "5",
      bounty: "$1500 USDC",
      status: QuestStatus.Active,
    },
    {
      img: "/quest-hen.png",
      title: "EL Pollo Loco",
      timer: "00:05:00",
      participants: "2",
      bounty: "$1500 USDC",
      status: QuestStatus.Ended,
    },
    {
      img: "/quest-hen.png",
      title: "EL Pollo Loco",
      timer: "00:05:00",
      participants: "7",
      bounty: "$1500 USDC",
      status: QuestStatus.Active,
    },
    {
      img: "/quest-hen.png",
      title: "EL Pollo Loco",
      timer: "00:05:00",
      participants: "9",
      bounty: "$1500 USDC",
      status: QuestStatus.Ended,
    },
  ];
  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <h1 className="text-4xl font-semibold text-center uppercase">
        DashBoard
      </h1>
      <div className="my-5 flex flex-wrap gap-3">
        {quests.map((quest) => (
          <PartnerQuestCard {...quest} key={quest.img} />
        ))}
      </div>

      <Footer />
    </div>
  );
}
