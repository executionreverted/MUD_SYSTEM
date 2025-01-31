import { useComponentValue } from "@latticexyz/react";
import { useMUD } from "../MUDContext";

export const usePlayer = () => {
    const {
        network: { playerEntity },
        components,
    } = useMUD();
    const player = useComponentValue(components.Player, playerEntity);
    const name = useComponentValue(components.Name, playerEntity);
    const state = useComponentValue(components.State, playerEntity);
    const level = useComponentValue(components.Level, playerEntity);
    const lastAction = useComponentValue(components.LastAction, playerEntity);
    const combined = {
        activated: player?.activated,
        name: name?.name,
        state: state?.state,
        level: level?.level,
        xp: level?.xp,
        lastAction: lastAction?.timestamp,
    }
    return combined
};  