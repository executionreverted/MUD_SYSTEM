import { createContext, useContext, useState, useEffect, ReactNode } from "react";
import { GetContractReturnType, parseAbi, Hex } from 'viem';
import { ERC20_ABI } from "../utils/abiFragments";
import { useGetContract } from "../hooks/useGetContract";
import { useMUD } from "../MUDContext";

interface ERC20State {
  balance?: bigint;
  address?: Hex;
  contract?: GetContractReturnType;
}

interface ERC20ContextType {
  erc20State: Record<string, ERC20State>;
  getBalance: (assetName: string) => bigint;
  refetchBalance: (assetName: string) => Promise<Hex>;
  loading: boolean;
}

const ERC20Context = createContext<ERC20ContextType | undefined>(undefined);

export function ERC20Provider({ children }: { children: ReactNode }) {
  const {
    network: { walletClient, worldContract, publicClient },
  } = useMUD();
  const [loading, setLoading] = useState(false);
  const [erc20State, setERC20State] = useState<Record<string, ERC20State>>({});

  async function fetchBalance(assetName: string) {
    const balance = await (erc20State[assetName].contract as any)?.read.balanceOf([walletClient.account.address]);
    setERC20State((prev) => ({
      ...prev,
      [assetName]: { ...prev[assetName], balance },
    }));
  }

  async function refetchBalance(assetName: string): Promise<Hex> {
    if (erc20State[assetName]?.contract) {
      await fetchBalance(assetName);
      return erc20State[assetName].address!;
    }

    try {
      setLoading(true);
      const address = await (worldContract as any).read["app__get" + assetName + "Address"]?.();
      console.log(assetName, "Address", address);
      const contract = useGetContract(address, parseAbi(ERC20_ABI), publicClient, walletClient);
      const balance = await contract.read.balanceOf([walletClient.account.address]);

      setERC20State((prev) => ({
        ...prev,
        [assetName]: { balance, address, contract },
      }));
      return address;
    } catch (error) {
      console.error(error);
      return "0x0000000000000000000000000000000000000000";
    } finally {
      setLoading(false);
    }
  }

  const getBalance = (assetName: string) => {
    return erc20State[assetName]?.balance || 0n;
  };

  const value = {
    erc20State,
    getBalance,
    refetchBalance,
    loading
  };

  return <ERC20Context.Provider value={value}>{children}</ERC20Context.Provider>;
}

export function useERC20() {
  const context = useContext(ERC20Context);
  if (context === undefined) {
    throw new Error("useERC20 must be used within an ERC20Provider");
  }
  return context;
}