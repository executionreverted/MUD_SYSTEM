// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { Config } from "../codegen/index.sol";
import { OnlyAdmin } from "../lib/CommonUtils.sol";
import { EffectType, DurationType, TargetType } from "../codegen/common.sol";
import { Consumable, ConsumableData } from "../codegen/tables/Consumable.sol";
contract ConsumableSystem is System {
  modifier onlyAdmin() {
    if (_msgSender() != Config.getAdminAddress()) revert OnlyAdmin();
    _;
  }

  function createConsumable(
    uint256 id,
    uint256 itemId,
    uint256 charges,
    uint256 maxCharges,
    uint256 duration,
    EffectType effect,
    DurationType durationType,
    TargetType targetType
  ) external onlyAdmin {
    Consumable.set(
      id,
      ConsumableData({
        itemId: itemId,
        charges: charges,
        maxCharges: maxCharges,
        duration: duration,
        effect: effect,
        durationType: durationType,
        targetType: targetType
      })
    );
  }

  function getConsumable(uint256 id) public view returns (ConsumableData memory) {
    return Consumable.get(id);
  }
}
