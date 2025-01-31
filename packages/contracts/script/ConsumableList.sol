// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import { ConsumableData, Consumable } from "../src/codegen/tables/Consumable.sol";
import { Rarity } from "../src/codegen/common.sol";
import { EffectType, DurationType, TargetType } from "../src/codegen/common.sol";
library ConsumableList {
  function getConsumables() internal pure returns (ConsumableData[] memory) {
    ConsumableData[] memory items = new ConsumableData[](10);

    // Consumable Item Objects

    items[0] = ConsumableData({
      itemId: 1,
      charges: 10,
      maxCharges: 10,
      duration: 10,
      effect: EffectType.HEALING,
      durationType: DurationType.SECONDS,
      targetType: TargetType.SELF
    });
    items[1] = ConsumableData({
      itemId: 2,
      charges: 10,
      maxCharges: 10,
      duration: 10,
      effect: EffectType.HEALING,
      durationType: DurationType.SECONDS,
      targetType: TargetType.SELF
    });
    items[2] = ConsumableData({ 
      itemId: 3,
      charges: 10,
      maxCharges: 10,
      duration: 10,
      effect: EffectType.HEALING,
      durationType: DurationType.SECONDS,
      targetType: TargetType.SELF
    });
    items[3] = ConsumableData({
      itemId: 4,
      charges: 10,
      maxCharges: 10,
      duration: 10,
      effect: EffectType.HEALING,
      durationType: DurationType.SECONDS,
      targetType: TargetType.SELF
    });
    items[4] = ConsumableData({
      itemId: 5,
      charges: 5,
      maxCharges: 5,
      duration: 30,
      effect: EffectType.BUFF,
      durationType: DurationType.MINUTES,
      targetType: TargetType.SELF
    });
    items[5] = ConsumableData({
      itemId: 6,
      charges: 3,
      maxCharges: 3,
      duration: 60,
      effect: EffectType.BUFF,
      durationType: DurationType.MINUTES,
      targetType: TargetType.ALLY
    });
    items[6] = ConsumableData({
      itemId: 7,
      charges: 1,
      maxCharges: 1,
      duration: 120,
      effect: EffectType.BUFF,
      durationType: DurationType.MINUTES,
      targetType: TargetType.SELF
    });
    items[7] = ConsumableData({
      itemId: 8,
      charges: 15,
      maxCharges: 15,
      duration: 5,
      effect: EffectType.DAMAGE,
      durationType: DurationType.SECONDS,
      targetType: TargetType.ENEMY
    });
    items[8] = ConsumableData({
      itemId: 9,
      charges: 2,
      maxCharges: 2,
      duration: 45,
      effect: EffectType.DEBUFF,
      durationType: DurationType.SECONDS,
      targetType: TargetType.SELF
    });
    items[9] = ConsumableData({
      itemId: 10,
      charges: 1,
      maxCharges: 1,
      duration: 300,
      effect: EffectType.DEBUFF,
      durationType: DurationType.SECONDS,
      targetType: TargetType.SELF
    });
    
    return items;
  }
}

