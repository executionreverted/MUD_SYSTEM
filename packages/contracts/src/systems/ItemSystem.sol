// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Item, ItemData } from "../codegen/Tables/Item.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { Config } from "../codegen/index.sol";
import { OnlyAdmin } from "../lib/Common.sol";

contract ItemSystem is System {
  modifier onlyAdmin() {
    if (_msgSender() != Config.getAdminAddress()) revert OnlyAdmin();
    _;
  }

  function createItem(uint256 id, uint256 rarity, uint256 level, uint256 salePrice) external onlyAdmin {
    Item.set(id, ItemData({ rarity: rarity, level: level, salePrice: salePrice }));
  }

  function getItem(uint256 id) public view returns (ItemData memory) {
    return Item.get(id);
  }
}
