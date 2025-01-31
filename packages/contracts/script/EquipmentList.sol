// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Equipment, EquipmentData } from "../src/codegen/tables/Equipment.sol";
import { EquipmentSlot } from "../src/codegen/common.sol";

library EquipmentList {
  function getEquipment() internal pure returns (EquipmentData[] memory) {
    EquipmentData[] memory equipment = new EquipmentData[](10);
    
    equipment[0] = EquipmentData({
      itemId: 0,
      slot: EquipmentSlot.HEAD,
      durability: 100,
      maxDurability: 100
    });
    equipment[1] = EquipmentData({
      itemId: 1,
      slot: EquipmentSlot.CHEST, 
      durability: 100,
      maxDurability: 100
    });
    equipment[2] = EquipmentData({
      itemId: 2,
      slot: EquipmentSlot.LEGS,
      durability: 100,
      maxDurability: 100
    });
    equipment[3] = EquipmentData({
      itemId: 3,
      slot: EquipmentSlot.FEET,
      durability: 100,
      maxDurability: 100
    });
    equipment[4] = EquipmentData({
      itemId: 4,
      slot: EquipmentSlot.HANDS,
      durability: 100,
      maxDurability: 100
    });
    equipment[5] = EquipmentData({
      itemId: 5,
      slot: EquipmentSlot.NECK,
      durability: 100,
      maxDurability: 100
    });
    equipment[6] = EquipmentData({
      itemId: 6,
      slot: EquipmentSlot.RING1,
      durability: 100,
      maxDurability: 100
    });
    equipment[7] = EquipmentData({
      itemId: 7,
      slot: EquipmentSlot.RING2,
      durability: 100,
      maxDurability: 100
    });
    equipment[8] = EquipmentData({
      itemId: 8,
      slot: EquipmentSlot.WEAPON,
      durability: 100,
      maxDurability: 100
    });
    equipment[9] = EquipmentData({
      itemId: 9,
      slot: EquipmentSlot.SHIELD,
      durability: 100,
      maxDurability: 100
    });
    return equipment;
  }
}
