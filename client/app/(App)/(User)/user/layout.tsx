import UserDashBoard from "@/app/_components/Navbar/UserDashBoard";

export default function UserLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex justify-between mx-auto w-full max-w-screen-xl">
      <div className="basis-[20%]">
        <UserDashBoard />
      </div>
      <div className="basis-[80%]">{children}</div>
    </div>
  );
}
