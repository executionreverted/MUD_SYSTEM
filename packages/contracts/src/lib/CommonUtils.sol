// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { State } from "../codegen/index.sol";
import { PlayerState } from "../codegen/common.sol";
import { Config } from "../codegen/index.sol";

error OnlyAdmin();
error AdminAddressAlreadySet();
error InvalidState(PlayerState requiredState);
error Paused();

contract CommonUtils {
  modifier onlySpecificState(PlayerState requiredState) {
    address player = msg.sender;
    PlayerState state = State.get(player);

    if (state != requiredState) {
      revert InvalidState(requiredState);
    }
    _;
  }

  modifier onlyWhenNotPaused() {
    if (Config.getPaused()) {
      revert Paused();
    }
    _;
  }
}