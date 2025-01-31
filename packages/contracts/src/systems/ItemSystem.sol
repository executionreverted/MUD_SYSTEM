// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Item, ItemData } from "../codegen/tables/Item.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { Config } from "../codegen/index.sol";
import { OnlyAdmin } from "../lib/CommonUtils.sol";
import { Rarity } from "../codegen/common.sol";
import { console } from "forge-std/console.sol";

contract ItemSystem is System {
  modifier onlyAdmin() {
    console.log("tx.origin", tx.origin);
    console.log("Config.getAdminAddress()", Config.getAdminAddress());
    if (tx.origin != Config.getAdminAddress()) revert OnlyAdmin();
    _;
  }

  function createItem(uint256 id, Rarity rarity, uint256 level, uint256 salePrice) external onlyAdmin {
    Item.set(id, ItemData({ rarity: rarity, level: level, salePrice: salePrice }));
  }

  function getItem(uint256 id) public view returns (ItemData memory) {
    return Item.get(id);
  }
}
