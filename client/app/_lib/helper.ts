import { NFTStorage, File, Blob } from "nft.storage";
import toast from "react-hot-toast";

const NFT_STORAGE_TOKEN = process.env.NEXT_PUBLIC_NFT_STORAGE_KEY;

const client = new NFTStorage({
  token: NFT_STORAGE_TOKEN ?? "",
});

export const storeFiles = async ({ componentsData }: any) => {
  let arr = [];
  console.log(componentsData);
  toast.loading("Uploading to IPFS...", { id: "uploading" });
  for (const key in componentsData) {
    if (componentsData.hasOwnProperty(key) && componentsData[key]) {
      console.log(key, componentsData[key]);
      const imageFile = new File(componentsData[key], "nft.png", {
        type: "image/png",
      });
      const newFile = new File(
        [JSON.stringify({ image: imageFile, name: key })],
        `${key}.json`,
        {
          type: "application/json",
        }
      );

      console.log(newFile);
      arr.push(newFile);
    }
  }
  console.log(arr);
  if (arr.length === 0) {
    toast.dismiss("uploading");
    toast.error("No files selected!");
    return;
  }
  const cid = await client.storeDirectory(arr);
  console.log(cid);
  toast.dismiss("uploading");
  toast.success("Uploaded to IPFS!");
};

export const storeFile = async (
  file: BlobPart,
  title: string,
  description: string
) => {
  const imageFile = new File([file], "nft.png", {
    type: "image/png",
  });
  const metadata = await client.store({
    name: title,
    description: description,
    image: imageFile,
  });
  return "https://" + metadata.ipnft + ".ipfs.dweb.link/metadata.json";
};
