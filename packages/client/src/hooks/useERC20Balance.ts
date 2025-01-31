import { useERC20 } from "../contexts/ERC20Context";
import { useEffect } from "react";

export const useERC20Balance = (assetName: string) => {
  const { getBalance, refetchBalance, loading } = useERC20();

  useEffect(() => {
    refetchBalance(assetName);
  }, [assetName]);

  return {
    [assetName + "Balance"]: getBalance(assetName) as any || 0n as any,
    ["refetch" + assetName + "Balance"]: () => refetchBalance(assetName),
    [assetName + "Loading"]: loading
  };
};