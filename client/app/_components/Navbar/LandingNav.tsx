import Link from "next/link";
import { cn } from "../../_lib/utils";
import Image from "next/image";

const LandingNavbar = ({ className }: { className?: string }) => {
  return (
    <nav
      className={cn(
        "w-full bg-[hsl(var(--primary))] flex justify-between items-center h-16 rounded-2xl px-3 py-5",
        className
      )}
    >
      <div className="flex space-x-2">
        <Image
          src="/logo.svg"
          alt="LandingNavbar-logo"
          width={40}
          height={40}
          className="p-1 h-14"
        />
        <h2 className="font-extrabold my-auto uppercase text-2xl">
          monalizard
        </h2>
      </div>

      <Link
        href="/user/signup"
        className={
          "bg-white flex justify-between items-center rounded-xl space-x-3 py-2 px-2 border-b-4 border-black/[0.4] hover:translate-y-[3px] hover:border-none transition-transform duration-300"
        }
      >
        <div className="flex items-center justify-center space-x-2">
          <Image
            src="/puzzle.svg"
            alt="user"
            width={40}
            height={40}
            className="h-6 w-6"
          />
          <h2>Start Puzzling</h2>
        </div>
      </Link>
    </nav>
  );
};

export default LandingNavbar;
