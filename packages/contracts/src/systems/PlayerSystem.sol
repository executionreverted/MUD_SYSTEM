// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import { Player, Level, Name, State, LastAction } from "../codegen/index.sol";
import { PlayerState } from "../codegen/common.sol";

contract PlayerSystem is System {
  function createPlayer(string memory name) public returns (bool) {
    Player.set(tx.origin, true);
    Name.set(tx.origin, name);
    State.set(tx.origin, PlayerState.IDLE);
    LastAction.set(tx.origin, block.timestamp);
    Level.set(tx.origin, 0, 1);
    return true;
  }
}
