import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "./MUDContext";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { useState } from "react";
import MyCharacter from "./components/MyCharacter";
import { formatEther } from "viem";
import { useERC20Balance } from "./hooks/useERC20Balance";

export const App = () => {
  const {
    components: { },
    systemCalls: { createCharacter, mintDevGold, mintDevSilver },
  } = useMUD();
  const [name, setName] = useState("");

  const { GoldBalance, refetchGoldBalance } = useERC20Balance("Gold");
  const { SilverBalance, refetchSilverBalance } = useERC20Balance("Silver");

  return (
    <>
      <MyCharacter />
      <div>
        <p>Gold Balance: {formatEther(GoldBalance)}</p>
        <p>Silver Balance: {formatEther(SilverBalance)}</p>
      </div>
      <div className="flex flex-col gap-2">
        <input type="text" onChange={(e) => setName(e.target.value)} />
        <button
          type="button"
          onClick={async (event) => {
            event.preventDefault();
            console.log("new character creation:", await createCharacter(name));
          }}
        >
          Create Character
        </button>

        <button
          type="button"
          onClick={async (event) => {
            event.preventDefault();
            await mintDevGold(() => refetchGoldBalance("Gold"));
          }}
        >
          Mint Gold
        </button>

        <button
          type="button"
          onClick={async (event) => {
            event.preventDefault();
            await mintDevSilver(() => refetchSilverBalance("Silver"));
          }}
        >
          Mint Silver
        </button>
      </div>

    </>
  );
};
