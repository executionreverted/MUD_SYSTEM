import "react"
import { useMUD } from "../MUDContext";
import { useComponentValue } from "@latticexyz/react";
import { usePlayer } from "../hooks/usePlayer";

export const MyCharacter = () => {
    const { activated, name, state, level, xp, lastAction } = usePlayer();
    return <div>
        <h1>My Character</h1>
        {activated ? <div>
            <p>Name: {name}</p>
            <p>State: {state}</p>
            <p>Level: {level?.toString()}</p>
            <p>XP: {xp?.toString()}</p>
            <p>Last Action: {lastAction?.toString()}</p>
        </div>: <div>
            <p>You haven't created a character yet. Create one to get started.</p>
        </div>}
    </div>;
};

export default MyCharacter;