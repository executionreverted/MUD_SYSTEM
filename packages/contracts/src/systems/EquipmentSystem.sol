// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Item, ItemData } from "../codegen/Tables/Item.sol";
import { Equipment, EquipmentData } from "../codegen/Tables/Equipment.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { Config } from "../codegen/index.sol";
import { OnlyAdmin } from "../lib/CommonUtils.sol";
import { EquipmentSlot } from "../codegen/common.sol";

contract EquipmentSystem is System {
  modifier onlyAdmin() {
    if (_msgSender() != Config.getAdminAddress()) revert OnlyAdmin();
    _;
  }

  function createEquipment(uint256 id, EquipmentSlot slot, uint256 itemId, uint256 durability, uint256 maxDurability) external onlyAdmin {
    Equipment.set(id, EquipmentData({ slot: slot, itemId: itemId, durability: durability, maxDurability: maxDurability }));
  }

  function getEquipment(uint256 id) public view returns (EquipmentData memory) {
    return Equipment.get(id);
  }
}
