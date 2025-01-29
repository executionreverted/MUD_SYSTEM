// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import "forge-std/Test.sol";
import { MudTest } from "@latticexyz/world/test/MudTest.t.sol";
import { getKeysWithValue } from "@latticexyz/world-modules/src/modules/keyswithvalue/getKeysWithValue.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { Player, Name, State, LastAction, Level } from "../src/codegen/index.sol";
import { PlayerState } from "../src/codegen/common.sol";
import { console } from "forge-std/console.sol";
import { LevelData } from "../src/codegen/tables/Level.sol";

contract PlayerTest is MudTest {
  function testWorldExists() public {
    uint256 codeSize;
    address addr = worldAddress;
    assembly {
      codeSize := extcodesize(addr)
    }
    assertTrue(codeSize > 0);
  }

  function testPlayer() public {
    // Expect the counter to be 1 because it was incremented in the PostDeploy script.
    // uint32 counter = Counter.get();
    // assertEq(counter, 1);

    // // Expect the counter to be 2 after calling increment.
    // IWorld(worldAddress).app__increment();
    // counter = Counter.get();
    // assertEq(counter, 2);
    IWorld(worldAddress).app__createPlayer("test_player");
    console.log("Address: ", tx.origin);


    bool activated = Player.get(tx.origin);
    string memory name = Name.get(tx.origin);
    PlayerState state = State.get(tx.origin);
    LevelData memory levelData = Level.get(tx.origin);

    assertEq(levelData.level, 1);
    console.log("Level:");
    console.log(string(abi.encodePacked(levelData.level)));
    
    assertEq(levelData.xp, 0);
    console.log("XP:");
    console.log(string(abi.encodePacked(levelData.xp)));

    assertEq(activated, true);
    console.log("Activated: ", activated);

    assertEq(name, "test_player");
    console.log("Name: ", name);

    assertEq(uint256(state), uint256(PlayerState.IDLE));
    console.log("State: ", uint256(state));
  }
}
