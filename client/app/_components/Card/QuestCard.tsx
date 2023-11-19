import Image from "next/image";
import React from "react";
import { buttonVariants } from "../ui/button";

const QuestCard = ({ img }: { img: string }) => {
  return (
    <div className="w-full border my-2 border-[hsl(var(--primary))] flex rounded-xl overflow-hidden ">
      <section className="w-[23%] flex justify-center items-center">
        <Image
          src={img}
          alt="hen-quest"
          width={1024}
          height={1024}
          className="rounded-xl px-2 py-1 my-auto"
        />
      </section>
      <section className="w-[55%] flex flex-col space-y-3 py-3 px-2">
        <h2 className="text-3xl font-semibold">&quot;El Pollo loco&quot;</h2>
        <h3>
          Lorem ipsum dolor sit amet consectetur adipisicing elit. Ducimus velit
          debitis tempora iusto veniam earum eius magni, suscipit placeat
          tempore eos inventore et eligendi enim consequuntur quas incidunt
          delectus adipisci!
        </h3>
        <div className="flex space-x-3">
          <button
            className={buttonVariants({
              variant: "outline",
              className:
                "hover:scale-[0.95] transition-transform duration-300 space-x-2",
            })}
          >
            <Image
              src="/chat.svg"
              alt="chat-pic"
              width={40}
              height={40}
              className="w-6 h-6"
            />
            <h2>#elpolloloco</h2>
          </button>
          <button
            className={buttonVariants({
              variant: "outline",
              className:
                "hover:scale-[0.95] transition-transform duration-300 space-x-2",
            })}
          >
            <Image
              src="/participants.svg"
              alt="chat-pic"
              width={40}
              height={40}
              className="w-6 h-6"
            />
            <h2>5 participants</h2>
          </button>
        </div>
      </section>
      <section className="w-[22%] bg-[hsl(var(--primary))] p-2 flex flex-col items-center justify-around">
        <section className="h-[50%] bg-black flex flex-col rounded-xl overflow-hidden">
          <div className="h-[52%]">
            <Image
              src="/gnoisis.jpg"
              alt="ques-sponsor"
              width={250}
              height={250}
              className=""
            />
          </div>
          <div className="h-[48%] flex flex-col justify-center items-center">
            <section className="flex space-x-2 justify-center items-center ">
              <Image
                src="/timer.svg"
                alt="timer"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="font-semibold text-lg text-[#EFB359]">
                Time left:
              </h2>
            </section>
            <h2 className="font-semibold text-lg text-[#EFB359]">00:05:00</h2>
          </div>
        </section>
        <section className="flex justify-center items-center space-x-2">
          <Image
            src="/puzzle.svg"
            alt="chat-pic"
            width={40}
            height={40}
            className="w-6 h-6"
          />
          <h2 className="font-semibold text-2xl">15 Pieces</h2>
        </section>
        <section className="flex justify-center items-center space-x-1">
          <Image
            src="/bounty.svg"
            alt="chat-pic"
            width={40}
            height={40}
            className="w-6 h-6"
          />
          <h2 className="font-semibold text-2xl">$1500 USDC</h2>
        </section>
      </section>
    </div>
  );
};

export default QuestCard;
