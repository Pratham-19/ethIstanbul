import Link from "next/link";
import MaxWidthWrapper from "@/app/_components/MaxWidthWrapper";
import { buttonVariants } from "@/app/_components/ui/button";
import React from "react";

export default function Home() {
  return (
    <MaxWidthWrapper className="min-h-screen flex flex-col items-center justify-center text-center">
      <h1 className="text-3xl">User</h1>
    </MaxWidthWrapper>
  );
}
