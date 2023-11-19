import Navbar from "@/app/_components/Navbar/Navbar";
import PromoterDashBoard from "@/app/_components/Navbar/PromoterDashBoard";

export default function UserLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex justify-between mx-auto w-full max-w-screen-xl max-h-screen py-2 px-4  md:px-6 lg:py-4 space-x-2 overflow-hidden ">
      <div className="basis-[20%]">
        <PromoterDashBoard />
      </div>
      <div className="basis-[80%] relative pb-20 px-4">
        <Navbar className="" />
        {children}
      </div>
    </div>
  );
}
