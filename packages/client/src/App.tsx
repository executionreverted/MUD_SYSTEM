import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "./MUDContext";
import { singletonEntity } from "@latticexyz/store-sync/recs";
import { useState } from "react";
import MyCharacter from "./components/MyCharacter";

export const App = () => {
  const {
    components: {  },
    systemCalls: { createCharacter },
  } = useMUD();
  const [name, setName] = useState("");

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
      </div>

    </>
  );
};
