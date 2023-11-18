export default function PageLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="flex justify-between mx-auto w-full max-w-screen-xl">
      <h1 className="basis-[20%] border border-black">Hey</h1>
      <div className="basis-[80%] border border-red">
        <div className="">NavBar</div>
        {children}
      </div>
    </div>
  );
}
