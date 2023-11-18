import Link from "next/link";
import MaxWidthWrapper from "./_components/MaxWidthWrapper";
import { buttonVariants } from "./_components/ui/button";

export default function Home() {
  return (
    <MaxWidthWrapper className="min-h-screen flex flex-col items-center justify-center text-center">
      <h1 className="text-3xl">Hola Amigos </h1>
      <div className="flex my-5 space-x-5 ">
        <Link
          href="/promter/dashboard"
          className={buttonVariants({
            size: "lg",
            className: "px-7",
            variant: "outline",
          })}
          target="_blank"
        >
          Promter
        </Link>
        <Link
          href="/user/dashboard"
          className={buttonVariants({
            size: "lg",
            className: "px-10",
          })}
          target="_blank"
        >
          User
        </Link>
      </div>
    </MaxWidthWrapper>
  );
}
