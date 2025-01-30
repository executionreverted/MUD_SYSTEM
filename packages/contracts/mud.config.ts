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
    PlayerState: ["IDLE", "IN_COMBAT", "INJURED", "DEAD", "RESTING", "TRAVELLING", "FISHING"],
    DurationType: ["SECONDS", "MINUTES", "HOURS", "DAYS"],
    EffectType: ["HEALING", "DAMAGE", "BUFF", "DEBUFF", "AOE_HEALING", "AOE_DAMAGE"],
    EquipmentSlot: ["HEAD", "CHEST", "LEGS", "FEET", "HANDS", "NECK", "RING1", "RING2", "WEAPON", "SHIELD", "OFFHAND"],
    TargetType: ["SELF", "PLAYER", "ENEMY", "ALLY", "ALL"],
    CurrencyType: ["GOLD", "SILVER", "THIRD_PARTY"],
    Rarity: ["COMMON", "UNCOMMON", "RARE", "EPIC", "LEGENDARY", "MYTHIC"],
  },
  systems: {
    ConfigSystem: {
      name: "Config",
    },
    TokenMinterSystem: {
      name: "TokenMinter",
    },
    ItemSystem: {
      name: "Item",
    },
    EquipmentSystem: {
      name: "Equipment",
    },
    ConsumableSystem: {
      name: "Consumable",
    },
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



    // Item System Schema
    // There are 2 types of items: Equipment and Item. Item is the base type for all items.
    // Equipment is a type of item that can be equipped by a player. 
    // They mirror base properties from Item. They are erc721s.
    Item: {
      schema: {
        id: "uint256",
        level: "uint256",
        salePrice: "uint256",
        rarity: "Rarity",
      },
      key: ["id"],
    },
    Equipment: {
      schema: {
        id : "uint256",
        itemId: "uint256",
        slot: "uint256",
        durability: "uint256",
        maxDurability: "uint256",
      },
      key: ["id"],
    },
    Consumable: {
      schema: {
        id: "uint256",
        itemId: "uint256",
        charges: "uint256",
        maxCharges: "uint256",
        duration: "uint256",
        effect: "EffectType",
        durationType: "DurationType",
        targetType: "TargetType",
      },
      key: ["id"],
    },
    Enemy: {
      schema: {
        id: "uint256",
        level: "uint256",
      },
      key: ["id"],
    },
    LootTable: {
      schema: {
        id: "uint256",
        itemDropChance: "uint256",
        goldDropChance: "uint256",
        silverDropChance: "uint256",
        goldDropAmount: "uint256",
        silverDropAmount: "uint256",
        itemsToDrop: "uint256[]",
      },
      key: ["id"],
    },
    ShopPrice: {
      schema: {
        id: "uint256",
        price: "uint256",
        currencyType: "CurrencyType",
        currencyAddress: "address",
      },
      key: ["id"],
    },
    Shop: {
      schema: {
        id: "uint256",
        restockInterval: "uint256",
        lastRestock: "uint256",
        discountCurrencyType: "CurrencyType",
        discountPercentage: "uint256",
        discountCurrencyAddress: "address",
        itemsForSale: "uint256[]",
        stocks: "uint256[]",
        defaultPrices: "uint256[]",
        paymentCurrencyTypes: "uint256[]",
      },
      key: ["id"],
    },
  },
});
