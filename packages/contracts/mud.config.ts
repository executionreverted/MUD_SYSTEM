import { defineWorld } from "@latticexyz/world";
import { defineERC20Module } from "@latticexyz/world-module-erc20/internal";

export default defineWorld({
  deploy: {
    upgradeableWorldImplementation: true,
  },
  
  namespace: "app",
  modules: [
    defineERC20Module({
      namespace: "goldToken",
      name: "GOLD",
      symbol: "GLD",
    }),
    defineERC20Module({
      namespace: "silverToken",
      name: "Silver",
      symbol: "SLV",
    }),
  ],
  enums: {
    PlayerState: ["IDLE", "IN_COMBAT", "INJURED", "DEAD"],
  },
  systems: {
    ConfigSystem: {

    },
    TokenMinterSystem: {
      deploy: {
        disabled: true
      }
    }
  },
  tables: {
    // Add additional config to the schema below
    Config: {
      schema: {
        adminAddress: "address",
        paused: "bool",
      },
      key: [],
    },
    Player: {
      schema: {
        player: "address",
        activated: "bool",
      },
      key: ["player"], // Player player ID
    },
    Level: {
      schema: {
        player: "address",
        xp: "uint256",
        level: "uint256",
      },

      key: ["player"], // Player player ID
    },
    Name: {
      schema: {
        player: "address",
        name: "string",
      },
      key: ["player"], // Player player ID
    },
    State: {
      schema: {
        player: "address",
        state: "PlayerState",
      },
      key: ["player"], // Player player ID
    },
    LastAction: {
      schema: {
        player: "address",
        timestamp: "uint256",
      },
      key: ["player"], // Player player ID
    },
  },
});
