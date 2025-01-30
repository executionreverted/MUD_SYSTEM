import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "./MUDContext";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { useState } from "react";
import MyCharacter from "./components/MyCharacter";
import useGoldBalance from "./hooks/useGoldBalance";

export const App = () => {
  const {
    components: {  },
    systemCalls: { createCharacter, mintDevGold, mintDevSilver },
  } = useMUD();
  const [name, setName] = useState("");

  const goldBalance = useGoldBalance();

  return (
    <>
      <MyCharacter />
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
            console.log("mint gold:", await mintDevGold());
          }}
        >
          Mint Gold
        </button>

        <button
          type="button"
          onClick={async (event) => {
            event.preventDefault();
            console.log("mint silver:", await mintDevSilver());
          }}
        >
          Mint Silver
        </button>
      </div>

    </>
  );
};
