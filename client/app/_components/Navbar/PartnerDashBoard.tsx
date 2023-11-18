"use client";
import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import React, { useEffect, useState } from "react";

const UserDashBoard = () => {
  const pathname = usePathname();
  const [showDashboard, setShowDashboard] = useState(true);
  const [showQuest, setShowQuest] = useState(false);
  const [showMarketplace, setShowMarketplace] = useState(false);

  const menu: {
    name: string;
    icon: string;
    link: string;
    isActive: boolean;
  }[] = [
    {
      name: "Dashboard",
      icon: "/dashboard.svg",
      link: "/user/dashboard",
      isActive: showDashboard,
    },
    {
      name: "Quests",
      icon: "/quest-nav.svg",
      link: "/user/quest",
      isActive: showQuest,
    },
    {
      name: "Marketplace",
      icon: "/marketplace.svg",
      link: "/user/marketplace",
      isActive: showMarketplace,
    },
  ];

  useEffect(() => {
    const getPath = menu.find((item) => item.link === pathname);
    if (!getPath) return;
    switch (getPath.name) {
      case "Dashboard":
        setShowDashboard(true);
        setShowQuest(false);
        setShowMarketplace(false);
        break;
      case "Quests":
        setShowDashboard(false);
        setShowQuest(true);
        setShowMarketplace(false);
        break;
      case "Marketplace":
        setShowDashboard(false);
        setShowQuest(false);
        setShowMarketplace(true);
        break;
      default:
        setShowDashboard(true);
        setShowQuest(false);
        setShowMarketplace(false);
    }
  }, [pathname]);
  return (
    <div className="bg-[hsl(var(--primary))] w-full h-[calc(100vh-1rem)]  lg:h-[calc(100vh-2rem)] rounded-2xl overflow-hidden">
      <div className="h-[29%] relative">
        <Image
          src="/user-lizard.jpg"
          alt="user"
          width={1024}
          height={1024}
          className="object-cover w-full h-full"
        />
        <div className="absolute inset-x-0 bottom-4 flex justify-center items-center bg-black rounded-xl w-[80%] mx-auto text-white space-x-2 py-2 opacity-80">
          <Image
            src="/quest.svg"
            alt="user"
            width={40}
            height={40}
            className="w-5 h-5"
          />
          <h2>Quester</h2>
        </div>
        <div className="absolute top-0 left-0 w-full h-full z-10 bg-[#fe8c27] opacity-[0.15] " />
      </div>
      <div className="h-[71%] px-3 flex flex-col justify-around">
        <section className="flex space-x-2 justify-center items-center mt-2">
          <Image
            src="/pic.png"
            alt="profile-pic"
            width={40}
            height={40}
            className="w-7 h-7 rounded-full"
          />
          <h2 className="text-xl">WRD2.lens</h2>
        </section>
        <section>
          {menu.map((item) => (
            <Link
              href={item.link}
              className={`flex items-center space-x-2 my-3 justify-start text-center pl-4 ${
                item.isActive ? "border-l-4 " : ""
              } cursor-pointer hover:scale-[1.03] transition-transform duration-300`}
              key={item.name}
            >
              <Image
                src={item.icon}
                alt={item.name}
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2>{item.name}</h2>
            </Link>
          ))}
        </section>
        <section className="w-full bg-[hsl(var(--secondary))] flex flex-col items-center  mx-auto rounded-xl text-center pt-3 pb-7 h-[51%]">
          <span className="flex mx-auto space-x-2">
            <Image
              src="/chat.svg"
              alt="user"
              width={40}
              height={40}
              className="w-6 h-6"
            />
            <h2>ChatRooms</h2>
          </span>
          <div className="flex flex-col mx-auto my-1 mt-3">
            <h2 className="my-2 cursor-pointer hover:scale-[1.03] transition-transform duration-300">
              # elpolloloco
            </h2>
            <h2 className="my-1 cursor-pointer hover:scale-[1.03] transition-transform duration-300">
              # elpolloloco
            </h2>
            <h2 className="my-1 cursor-pointer hover:scale-[1.03] transition-transform duration-300">
              # elpolloloco
            </h2>
          </div>
        </section>
      </div>
    </div>
  );
};
export default UserDashBoard;
