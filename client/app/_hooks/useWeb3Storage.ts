import { Web3Storage } from "web3.storage";
import { v4 as uuidv4 } from "uuid";

const useWeb3Storage = () => {
  const makeStorageClient = () => {
    return new Web3Storage({
      token: process.env.NEXT_PUBLIC_WEB3_STORAGE_API_KEY!,
    });
  };

  const storeFile = async (file: File) => {
    try {
      const client = makeStorageClient();
      const newFile = new File(
        [file],
        uuidv4() + "." + file.type.split("/")[1],
        {
          type: file.type,
        }
      );
      const cid = await client.put([newFile]);
      return "https://" + cid + ".ipfs.w3s.link/" + newFile.name;
    } catch (err) {
      console.error(err);
    }
  };

  const retrieveFile = async (cid: string) => {
    const client = makeStorageClient();
    const res = await client.get(cid);
    if (!res!.ok) {
      throw new Error(
        `Failed to get ${cid} - [${res!.status}] ${res!.statusText}`
      );
    }
    const file = await res!.files();
    // return file[0];
    return "https://" + file[0].cid + ".ipfs.w3s.link/" + file[0].name;
  };

  return { makeStorageClient, storeFile, retrieveFile };
};

export default useWeb3Storage;
