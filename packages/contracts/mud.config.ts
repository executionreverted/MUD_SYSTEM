import { defineWorld } from "@latticexyz/world";
import { defineERC20Module } from "@latticexyz/world-module-erc20/internal";
import { encodeAbiParameters, stringToHex } from "../client/node_modules/viem";
 

const erc721ModuleArgs = encodeAbiParameters(
  [
    { type: "bytes14" },
    {
      type: "tuple",
      components: [{ type: "string" }, { type: "string" }, { type: "string" }],
    },
  ],
  [stringToHex("items", { size: 14 }), ["In Game Items", "ITEM", "http://www.example.com/base/uri/goes/here"]],
);

export default defineWorld({
  deploy: {
    upgradeableWorldImplementation: true,
  },

  namespace: "app",
  modules: [
    defineERC20Module({
      namespace: "gold",
      name: "GOLD",
      symbol: "GLD",
    }),
    defineERC20Module({
      namespace: "silver",
      name: "Silver",
      symbol: "SLV",
    }),
    {
      artifactPath: "./out/ERC721PuppetModule.sol/ERC721PuppetModule.json",
      root: false,
      args: [],
    },
    {
      artifactPath: "./out/InGameERC721Module.sol/InGameERC721Module.json",
      root: false,
      args: [
        {
          type: "bytes",
          value: erc721ModuleArgs,
        },
      ],
    },
  ],
  enums: {
    PlayerState: ["IDLE", "IN_COMBAT", "INJURED", "DEAD"],
  },
  systems: {
    ConfigSystem: {

    },
    TokenMinterSystem: {
      name: "TokenMinter",
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
