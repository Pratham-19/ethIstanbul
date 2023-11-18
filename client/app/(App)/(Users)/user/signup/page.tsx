import React from "react";
import Image from "next/image";
import { buttonVariants } from "@/app/_components/ui/button";

const Signup = () => {
  const signIn: {
    name: string;
    icon: string;
  }[] = [
    {
      name: "Lens",
      icon: "/lens.svg",
    },
    {
      name: "Worldcoin",
      icon: "/worldcoin.svg",
    },
    {
      name: "WalletConnect",
      icon: "/walletcoin.svg",
    },
  ];
  return (
    <div className="w-screen h-screen flex">
      <div className="w-[57vw] flex flex-col justify-center items-center">
        <div className="flex space-x-2 my-4">
          <Image
            src="/logo.svg"
            alt="Navbar-logo"
            width={40}
            height={40}
            className="h-16 w-16"
          />
          <h2 className="font-extrabold my-auto uppercase text-3xl">
            monalizard
          </h2>
        </div>
        <h2 className="text-3xl my-4">Start Puzzling</h2>
        <section className="flex flex-col space-y-4 mt-7">
          {signIn.map((item) => (
            <button
              className={buttonVariants({
                variant: "outline",
                size: "lg",
                className:
                  "flex justify-center items-center space-x-2 hover:scale-[0.95] transition-transform duration-300 px-20 py-6 rounded-3xl shadow-lg",
              })}
              key={item.name}
            >
              <Image
                src={item.icon}
                alt="signup"
                width={40}
                height={40}
                className="h-6 w-6"
              />
              <h2>{item.name}</h2>
            </button>
          ))}
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
