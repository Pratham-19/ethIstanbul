"use client";
import React, { useRef, useState } from "react";
import Image from "next/image";
import toast from "react-hot-toast";
import Footer from "@/app/_components/Footer";
import { storeFile, storeFiles } from "@/app/_lib/helper";
import { Components } from "@/app/_lib/types";
import {
  prepareWriteContract,
  waitForTransaction,
  writeContract,
} from "wagmi/actions";
import EscrowAccount from "@/app/_abis/abi/Escrow.json";
import NFTDrop from "@/app/_abis/abi/NFTDrop.json";
import QuestNFT from "@/app/_abis/abi/QuestNFT.json";
import { parseEther } from "viem";
import { useAccount } from "wagmi";

const Create = () => {
  const { address } = useAccount();

  const [questName, setQuestName] = useState("");
  const [mainPic, setMainPic] = useState<string>();
  const [char1, setChar1] = useState<string>();
  const [char2, setChar2] = useState<string>();
  const [char3, setChar3] = useState<string>();
  const [char4, setChar4] = useState<string>();
  const [char5, setChar5] = useState<string>();
  const [char6, setChar6] = useState<string>();
  const [char7, setChar7] = useState<string>();
  const [char8, setChar8] = useState<string>();

  const mainRef = useRef<HTMLInputElement>(null);
  const char1Ref = useRef<HTMLInputElement>(null);
  const char2Ref = useRef<HTMLInputElement>(null);
  const char3Ref = useRef<HTMLInputElement>(null);
  const char4Ref = useRef<HTMLInputElement>(null);
  const char5Ref = useRef<HTMLInputElement>(null);
  const char6Ref = useRef<HTMLInputElement>(null);
  const char7Ref = useRef<HTMLInputElement>(null);
  const char8Ref = useRef<HTMLInputElement>(null);

  const [componentValues, setComponentValues] = useState<Components>({
    "1": null,
    "2": null,
    "3": null,
    "4": null,
    "5": null,
    "6": null,
    "7": null,
    "8": null,
  });

  const [mainPicValue, setMainPicValue] = useState<File | null>(null);

  const [stakePrice, setStakePrice] = useState<string>("0");

  const components: {
    name: string;
    value: string | undefined;
    setValue: React.Dispatch<React.SetStateAction<string | undefined>>;
    ref: React.MutableRefObject<HTMLInputElement | null>;
  }[] = [
    {
      name: "1",
      value: char1,
      setValue: setChar1,
      ref: char1Ref,
    },
    {
      name: "2",
      value: char2,
      setValue: setChar2,
      ref: char2Ref,
    },
    {
      name: "3",
      value: char3,
      setValue: setChar3,
      ref: char3Ref,
    },
    {
      name: "4",
      value: char4,
      setValue: setChar4,
      ref: char4Ref,
    },
    {
      name: "5",
      value: char5,
      setValue: setChar5,
      ref: char5Ref,
    },
    {
      name: "6",
      value: char6,
      setValue: setChar6,
      ref: char6Ref,
    },
    {
      name: "7",
      value: char7,
      setValue: setChar7,
      ref: char7Ref,
    },
    {
      name: "8",
      value: char8,
      setValue: setChar8,
      ref: char8Ref,
    },
  ];
  const handlePicChange = async () => {
    const file = mainRef.current?.files![0];
    if (!file) {
      setMainPic("");
      return;
    }
    const fileTypes = ["image/jpeg", "image/jpg", "image/png"];
    const { size, type } = file;
    if (!fileTypes.includes(type)) {
      toast.error("File format must be either png or jpg");

      return false;
    }
    setMainPicValue(file);

    if (size / 1024 / 1024 > 2) {
      toast.error("File size exceeded the limit of 2MB");
      return false;
    }
    const reader = new FileReader();
    if (file) {
      reader.readAsDataURL(file);
    }
    reader.onload = (readerEvent) => {
      setMainPic(readerEvent!.target!.result!.toString());
    };
  };

  return (
    <div className="w-full h-full my-5 overflow-scroll">
      <h1 className="text-4xl font-semibold text-center uppercase">
        Create Puzzle
      </h1>
      <div>
        <input
          className="w-full h-14 rounded-xl bg-white my-5 px-5 outline-none"
          placeholder="Enter your quest name"
          value={questName}
          onChange={(e) => {
            setQuestName(e.target.value);
          }}
        />
        <section className="flex justify-between space-x-3 h-[35vh] my-10 ">
          <div className=" border-2 border-dashed rounded-xl flex flex-col justify-center items-center space-y-2 p-5 w-[30%] relative">
            <input
              type="file"
              ref={mainRef}
              onChange={handlePicChange}
              hidden
              name="mainPic"
              id="mainPic"
              className="w-full bg-[#1F2029]"
            />
            {!mainPic && (
              <button
                onClick={() => mainRef.current?.click()}
                className="flex flex-col justify-center items-center space-y-2"
              >
                <Image
                  src="/addpic.svg"
                  alt="hero"
                  width={40}
                  height={40}
                  className="w-12 h-12"
                />
                <h2 className="text-md font-semibold text-center">
                  Upload your final puzzle Image
                </h2>
              </button>
            )}
            {mainPic && (
              <>
                <Image
                  src={mainPic}
                  alt="mian-picture"
                  width={250}
                  height={250}
                  className="my-auto aspect-auto h-[98%] rounded-xl"
                />
                <button
                  type="submit"
                  onClick={() => setMainPic("")}
                  className="absolute right-2 top-2 p-1 rounded-lg bg-red-500 px-2 text-xs text-white"
                >
                  Reset
                </button>
              </>
            )}
          </div>
          <div className="w-[65%] flex flex-wrap gap-4 relative">
            {components.map((component, index) => (
              <div
                className=" border-2 border-dashed rounded-xl flex flex-col justify-center items-center w-28 h-24 relative"
                key={component.name}
              >
                <input
                  type="file"
                  ref={component.ref}
                  onChange={() => {
                    const file = component.ref.current?.files![0];
                    if (!file) {
                      component.setValue("");
                      return;
                    }
                    const fileTypes = ["image/jpeg", "image/jpg", "image/png"];
                    const { size, type } = file;
                    if (!fileTypes.includes(type)) {
                      toast.error("File format must be either png or jpg");

                      return false;
                    }

                    if (size / 1024 / 1024 > 2) {
                      toast.error("File size exceeded the limit of 2MB");
                      return false;
                    }

                    setComponentValues({
                      ...componentValues,
                      [component.name]: file,
                    });
                    const reader = new FileReader();
                    if (file) {
                      reader.readAsDataURL(file);
                    }
                    reader.onload = (readerEvent) => {
                      component.setValue(
                        readerEvent!.target!.result!.toString()
                      );
                    };
                  }}
                  hidden
                  name={component.name}
                  id={component.name}
                  className="w-full bg-[#1F2029]"
                />
                {!component.value && (
                  <button
                    onClick={() => component.ref.current?.click()}
                    className="flex flex-col justify-center items-center space-y-2"
                  >
                    <Image
                      src="/component.svg"
                      alt="hero"
                      width={40}
                      height={40}
                      className="w-12 h-12"
                    />
                    <h2>Comp {index + 1}</h2>
                  </button>
                )}
                {component.value && (
                  <>
                    <Image
                      src={component.value}
                      alt="mian-picture"
                      width={200}
                      height={200}
                      className="my-auto aspect-auto h-[98%] rounded-xl"
                    />
                    <button
                      type="submit"
                      onClick={() => component.setValue("")}
                      className="absolute right-1 top-1 p-1 rounded-lg bg-red-500 px-2 text-xs text-white"
                    >
                      X
                    </button>
                  </>
                )}
              </div>
            ))}
          </div>
        </section>
        <section className="flex justify-between my-5 ">
          <div className="flex justify-center items-center">
            <section className="flex border bg-[#200F00] justify-center items-center space-x-2 p-3 rounded-l-xl">
              <Image
                src="/timer.svg"
                alt="hero"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="text-[#EFB359] ">Set Timer</h2>
            </section>
            <input
              placeholder="DD:HH:MM:SS"
              className="bg-white border border-[#200F00] text-[#EFB359] py-3 px-1 rounded-r-xl outline-none w-[40%]"
              type="string"
            />
          </div>
          <div className="flex justify-center items-center">
            <section className="flex border bg-[#200F00] justify-center items-center space-x-2 p-3 rounded-l-xl">
              <Image
                src="/trophy.svg"
                alt="hero"
                width={40}
                height={40}
                className="w-6 h-6"
              />
              <h2 className="text-[#EFB359] ">Set Price (USDC)</h2>
            </section>
            <input
              type="number"
              onChange={(e) => {
                setStakePrice(e.target.value);
              }}
              className="bg-white border border-[#200F00] text-[#EFB359] py-3 px-1 w-[30%] rounded-r-xl outline-none"
              placeholder="$ 0.00"
            />
          </div>

          <button
            className="bg-[#200F00] text-[#EFB359] flex justify-center items-center space-x-2  py-3 px-1 rounded-xl"
            onClick={async () => {
              if (!questName) {
                toast.error("Quest name is required");
                return;
              }
              if (!mainPicValue) {
                toast.error("Main picture is required");
                return;
              }
              if (stakePrice == "0") {
                toast.error("Stake price is required to be > 0");
                return;
              }

              toast.loading("Uploading files", {
                id: "uploading",
              });
              const tokenUri = await storeFile(
                mainPicValue,
                questName,
                "this is a sample quest"
              );
              toast.dismiss("uploading");
              toast.success("Files uploaded successfully");
              toast.loading("Staking", {
                id: "staking",
              });
              const { request } = await prepareWriteContract({
                address: EscrowAccount.address as `0x${string}`,
                abi: EscrowAccount.abi,
                functionName: "stake",
                value: parseEther(stakePrice),
              });
              const { hash } = await writeContract(request);
              await waitForTransaction({ hash })
                .then(() => console.log("transaction confirmed"))
                .catch((error) => {
                  toast.dismiss("uploading");
                  console.log("error", error);
                });

              toast.dismiss("staking");
              toast.success("Staked successfully");
              toast.loading("Minting NFT", {
                id: "minting",
              });

              const { request: mintERC } = await prepareWriteContract({
                address: QuestNFT.address as `0x${string}`,
                abi: QuestNFT.abi,
                functionName: "mintQuestNFT",
                args: [address, tokenUri],
              });
              const { hash: hashERC } = await writeContract(mintERC);
              await waitForTransaction({ hash: hashERC })
                .then(() => console.log("transaction confirmed"))
                .catch((error) => {
                  toast.dismiss("minting");
                  console.log("error", error);
                });

              toast.success("Minted successfully");

              toast.loading("Uploading components", {
                id: "uploading",
              });
              const { request: uploadERC } = await prepareWriteContract({
                address: NFTDrop.address as `0x${string}`,
                abi: NFTDrop.abi,
                functionName: "setBaseURI",
                args: [
                  "https://bafybeiae7j2yx3ikp6fwgkqfxxq2cnccppovybd7guuk27eaeqhrlsf2la.ipfs.nftstorage.link/test",
                ],
              });
              const { hash: uploadyERC } = await writeContract(uploadERC);
              await waitForTransaction({ hash: uploadyERC })
                .then(() => console.log("transaction confirmed"))
                .catch((error) => {
                  toast.dismiss("uploading");
                  console.log("error", error);
                });

              toast.dismiss("uploading");
              toast.success("Uploaded successfully");
            }}
          >
            <Image
              src="/submit.svg"
              alt="hero"
              width={40}
              height={40}
              className="w-6 h-6"
            />
            <h2> Submit Stake</h2>
          </button>
        </section>
      </div>
      <Footer className="mt-4" />
    </div>
  );
};

export default Create;
