// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Item, ItemData } from "../src/codegen/Tables/Item.sol";
import { Rarity } from "../src/codegen/common.sol";

library ItemList {
  function getItems() internal pure returns (ItemData[] memory) {
    ItemData[] memory items = new ItemData[](10);

    // Common
    items[0] = ItemData({ rarity: Rarity.COMMON, level: 1, salePrice: 1e18 });
    items[1] = ItemData({ rarity: Rarity.COMMON, level: 5, salePrice: 5e18 });
    items[2] = ItemData({ rarity: Rarity.COMMON, level: 10, salePrice: 10e18 });
    items[3] = ItemData({ rarity: Rarity.COMMON, level: 15, salePrice: 15e18 });
    items[4] = ItemData({ rarity: Rarity.COMMON, level: 20, salePrice: 20e18 });
    items[5] = ItemData({ rarity: Rarity.COMMON, level: 25, salePrice: 25e18 });
    items[6] = ItemData({ rarity: Rarity.COMMON, level: 30, salePrice: 30e18 });
    items[7] = ItemData({ rarity: Rarity.COMMON, level: 35, salePrice: 35e18 });
    items[8] = ItemData({ rarity: Rarity.COMMON, level: 40, salePrice: 40e18 });
    items[9] = ItemData({ rarity: Rarity.COMMON, level: 45, salePrice: 45e18 });

    return items;
  }
}
