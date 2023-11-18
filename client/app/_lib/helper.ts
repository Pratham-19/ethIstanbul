import { NFTStorage, File, Blob } from "nft.storage";
import toast from "react-hot-toast";
import { v4 as uuidv4 } from "uuid";
import { FileValues } from "./types";

const NFT_STORAGE_TOKEN = process.env.NEXT_PUBLIC_NFT_STORAGE_KEY;

const client = new NFTStorage({
  token: NFT_STORAGE_TOKEN ?? "",
});

export const storeFiles = async (data: any) => {
  let arr = [];
  console.log(data);
  toast.loading("Uploading to IPFS...", { id: "uploading" });
  for (const key in data) {
    if (data.hasOwnProperty(key)) {
      const newFile = new File(
        [data[key]],
        uuidv4() + "." + data[key].type.split("/")[1],
        {
          type: data[key].type,
        }
      );
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
