import type { Metadata } from "next";
import "./globals.css";
import { Toaster } from "react-hot-toast";
import { Web3Modal } from "@/app/_context/Web3Modal";
export const metadata: Metadata = {
  title: "MonaLizard",
  description: "Crypto MonaLizard",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className={"min-h-screen antialiased font-space"}>
        <Web3Modal>{children}</Web3Modal>
        <Toaster position="top-center" reverseOrder={false} />
      </body>
    </html>
  );
}
