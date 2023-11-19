import Link from "next/link";
import MaxWidthWrapper from "./_components/MaxWidthWrapper";
import Image from "next/image";
import LandingNavbar from "./_components/Navbar/LandingNav";
import Footer from "./_components/Footer";

export default function Home() {
  const data: {
    icon: string;
    title: string;
  }[] = [
    {
      icon: "/l1.svg",
      title: "Meet new friends",
    },
    {
      icon: "/l2.svg",
      title: "Earn rewards",
    },
    {
      icon: "/l3.svg",
      title: "Collect NFTs",
    },
  ];
  return (
    <MaxWidthWrapper className="flex flex-col items-center py-4 relative overflow-x-hidden">
      <LandingNavbar />
      <main className="mt-7 w-[90%] mx-auto">
        <div className="bg-[#FFFBF8]/[0.3] border rounded-[50px] h-[63vh] flex backdrop-blur-sm pl-5 pr-7 mt-7 ">
          <div className="w-[35%] flex justify-center items-center ">
            <Image
              src="/hero.jpg"
              alt="hero"
              width={1021}
              height={1276}
              className=" w-[80%] h-[80%]"
            />
          </div>
          <section className=" w-[75%] flex flex-col justify-around items-center">
            <h2 className="text-7xl font-bold">Discover Web3</h2>
            <h3 className="italic text-2xl text-center">
              Explor Dapp with community solved puzzles.
            </h3>
            <div className="grid grid-cols-3 gap-3 ">
              {data.map((item) => (
                <div
                  key={item.title}
                  className="bg-[#200F00] flex justify-center items-center  space-x-2 rounded-xl p-2 hover:scale-95 transition-taransform duration-300 backdrop-blur-sm shadow-md"
                >
                  <Image
                    src={item.icon}
                    alt="hero"
                    width={60}
                    height={60}
                    className="p-1"
                  />
                  <h2 className="text-[#EFB359]">{item.title}</h2>
                </div>
              ))}
            </div>
          </section>
        </div>
        <div className="flex h-[38vh] my-10 ">
          <section>
            <Image
              src="/G.png"
              alt="hero"
              width={868}
              height={952}
              className="aspect-auto h-full px-8"
            />
          </section>
          <h2 className="italic text-2xl text-left my-auto font-semibold leading-[4rem]">
            “Get puzzle pieces from time to time or earn them by completing a
            task. But watch out, your time run fast. Make frens to complete
            them, don&apos;t be last”
          </h2>
        </div>

        <div className="flex justify-between h-[38vh] my-12">
          <section className="w-[30%] flex flex-col justify-between">
            <div className="bg-[#200F00] rounded-xl p-3 flex justify-center items-center space-x-2 h-[45%] text-[#EFB359]">
              <Image
                src="/participants-y.svg"
                alt="hero"
                width={40}
                height={40}
                className="h-10 w-10"
              />
              <h2>10 Active Puzzles</h2>
            </div>
            <div className="bg-[#200F00] rounded-xl p-3 flex justify-center items-center space-x-2 h-[45%] text-[#EFB359]">
              <Image
                src="/quest-y.svg"
                alt="hero"
                width={40}
                height={40}
                className="w-10 h-10"
              />
              <h2>50 Active Lizards</h2>
            </div>
          </section>

          <Link
            href="/user/signup"
            className="w-[30%] relative rounded-2xl overflow-hidden cursor-pointer hover:scale-[1.03] transition-transform duration-300"
          >
            <Image
              src="/user-lizard.jpg"
              alt="promoter"
              width={1024}
              height={1024}
              className="object-cover w-full h-full"
            />
            <div className="absolute inset-x-0 bottom-4 flex justify-center items-center bg-black rounded-xl w-[80%] mx-auto text-white space-x-2 py-2 opacity-80">
              <h2 className="uppercase text-lg font-semibold leading-loose">
                Start puzzling
              </h2>
            </div>
            <div className="absolute top-0 left-0 w-full h-full z-10 bg-[#fe8c27] opacity-[0.15] " />
          </Link>
          <Link
            href="/promoter/signup"
            className="w-[30%] relative rounded-2xl overflow-hidden cursor-pointer hover:scale-[1.03] transition-transform duration-300"
          >
            <Image
              src="/sponsor-lizard.jpg"
              alt="promoter"
              width={1024}
              height={1024}
              className="object-cover w-full h-full"
            />
            <div className="absolute inset-x-0 bottom-4 flex justify-center items-center bg-black rounded-xl w-[80%] mx-auto text-white space-x-2 py-2 opacity-80">
              <h2 className="uppercase text-lg font-semibold leading-loose">
                Promoter Project
              </h2>
            </div>
            <div className="absolute top-0 left-0 w-full h-full z-10 bg-[#fe8c27] opacity-[0.15] " />
          </Link>
        </div>
        <div className="flex h-[38vh] my-10 ">
          <section>
            <Image
              src="/D.png"
              alt="hero"
              width={808}
              height={920}
              className="aspect-auto h-full  pl-8 pr-16"
            />
          </section>
          <h2 className="italic text-2xl text-left my-auto font-semibold leading-[4rem]">
            “Don&apos;t struggle to get users on your dApp, With a puzzle
            you&apos;ll get a ton ASAP, Create a campaign now, easy and fast”
          </h2>
        </div>
      </main>
      <Footer className="w-full bg-[hsl(var(--primary))] flex justify-between items-center h-16 rounded-2xl px-3 py-5 " />

      <Image
        src="/a1.png"
        alt="l1"
        width={800}
        height={800}
        className="absolute -top-10 -right-5 -z-10 opacity-10"
      />
      <Image
        src="/a3.png"
        alt="l1"
        width={800}
        height={800}
        className="absolute bottom-10 -right-[300px] -z-10 opacity-10"
      />
      <Image
        src="/a2.png"
        alt="l1"
        width={800}
        height={800}
        className="absolute top-[500px] -left-72 -z-10 opacity-10"
      />
    </MaxWidthWrapper>
  );
}
