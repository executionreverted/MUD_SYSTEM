// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import "forge-std/Test.sol";
import { MudTest } from "@latticexyz/world/test/MudTest.t.sol";
import { getKeysWithValue } from "@latticexyz/world-modules/src/modules/keyswithvalue/getKeysWithValue.sol";

import { IWorld } from "../src/codegen/world/IWorld.sol";
import { console } from "forge-std/console.sol";
import { Config } from "../src/codegen/tables/Config.sol";

contract ConfigTest is MudTest {
  function testWorldExists() public {
    uint256 codeSize;
    address addr = worldAddress;
    assembly {
      codeSize := extcodesize(addr)
    }
    assertTrue(codeSize > 0);
  }

  function testConfig() public {
    // Expect the counter to be 1 because it was incremented in the PostDeploy script.
    // uint32 counter = Counter.get();
    // assertEq(counter, 1);

    // // Expect the counter to be 2 after calling increment.
    // IWorld(worldAddress).app__increment();
    // counter = Counter.get();
    // assertEq(counter, 2);

    vm.startPrank(address(0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38));

    address adminAddress = Config.getAdminAddress();
    assertEq(adminAddress, tx.origin);

    IWorld(worldAddress).app__setPaused(true);
    console.log("Address: ", tx.origin);

    console.log("Admin address:", adminAddress);
    console.log("Admin address:", adminAddress);

    bool paused = Config.getPaused();

    assertEq(paused, true);
    console.log("Paused:", paused);
    vm.stopPrank();

    vm.startPrank(address(0x000000000000000000000000000000000000dEaD));
    vm.expectRevert();
    IWorld(worldAddress).app__setPaused(false);
    paused = Config.getPaused();
    assertEq(paused, true);
    vm.stopPrank();
    console.log("Paused:", paused);

  }
}
