import { PartnerDashboardQuest, QuestStatus } from "@/app/_lib/types";
import Image from "next/image";
import React from "react";

const PartnerQuestCard = ({
  img,
  title,
  timer,
  participants,
  bounty,
  status,
}: PartnerDashboardQuest) => {
  return (
    <div className="w-[35vw] border my-2 border-black flex rounded-xl overflow-hidden ">
      <section className="relative w-[48%] flex flex-col items-center overflow-hidden border p-2">
        <Image
          src={img}
          alt="hen-quest"
          width={1024}
          height={1024}
          className={`rounded-xl my-auto ${
            status === QuestStatus.Active ? "" : "grayscale"
          }`}
        />
        <button className="flex justify-center items-center space-x-3 text-sm bg-black text-[#EFB359] uppercase rounded-b-xl h-fit w-full py-1 px-2 ">
          <Image
            src="/timer.svg"
            alt="chat-pic"
            width={40}
            height={40}
            className="w-6 h-6"
          />
          <h2>{timer}</h2>
        </button>
      </section>
      <section className="w-[52%] flex flex-col justify-around items-center py-3 px-2">
        <div className="min-h-[60%] flex flex-col justify-around items-center">
          <h2 className="text-2xl font-semibold">{title}</h2>
          <div className="flex justify-between space-x-2">
            <section className="flex justify-center items-center space-x-1">
              <Image
                src="/bounty.svg"
                alt="chat-pic"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="font-semibold text-lg">{bounty}</h2>
            </section>
            <section className="flex justify-center items-center space-x-2">
              <Image
                src="/participants.svg"
                alt="chat-pic"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="font-semibold text-lg text-center">
                {participants} questers
              </h2>
            </section>
          </div>
        </div>
        <section className="flex items-center justify-around">
          {status === QuestStatus.Active ? (
            <section className="flex bg-black space-x-2 rounded-xl py-1 px-2 justify-center items-center ">
              <Image
                src="/okActive.svg"
                alt="timer"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="font-semibold text-lg text-[#EFB359]">Active</h2>
            </section>
          ) : (
            <section className="flex bg-black rounded-xl py-1 px-2 space-x-2 justify-center items-center ">
              <Image
                src="/cancel.svg"
                alt="timer"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="font-semibold text-lg text-[#EFB359]">Ended</h2>
            </section>
          )}
        </section>
      </section>
    </div>
  );
};

export default PartnerQuestCard;
