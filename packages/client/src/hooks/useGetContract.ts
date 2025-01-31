import { Hex } from "viem";
import { useMUD } from "../MUDContext";
import { getContract } from "viem";

export const useGetContract = (address: Hex, abi: any, publicClient: any, walletClient: any) => {
    return getContract({
        address: address,
        abi: abi,
        client: { public: publicClient, wallet: walletClient },
    }) as any;
};


export default useGetContract;