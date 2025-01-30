// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { Config } from "../src/codegen/tables/Config.sol";
import { IWorld } from "../src/codegen/world/IWorld.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { WorldRegistrationSystem } from "@latticexyz/world/src/modules/init/implementations/WorldRegistrationSystem.sol";
import { TokenMinterSystem } from "../src/systems/TokenMinterSystem.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";

contract PostDeploy is Script {
  function run(address worldAddress) external {
    // Specify a store so that you can use tables directly in PostDeploy
    StoreSwitch.setStoreAddress(worldAddress);

    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    address deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    console.log("Deployer address:", tx.origin);
    IWorld(worldAddress).app__setAdminAddress(tx.origin);

    WorldRegistrationSystem world = WorldRegistrationSystem(worldAddress);
    ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, "goldToken", "TokenMinter");
    TokenMinterSystem mySys = new TokenMinterSystem();
    world.registerSystem(systemResource, mySys, true);
    world.registerFunctionSelector(systemResource, "mintGold(address,uint256)");

    vm.stopBroadcast();





    // WorldRegistrationSystem world = WorldRegistrationSystem(worldAddress);
    // ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("goldToken"));
    // ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, "tokenMinter", "TokenMinter");

    // world.registerNamespace(namespaceResource);
    // StoreSwitch.setStoreAddress(worldAddress);
    // Messages.register();
    // MessageSystem messageSystem = new MessageSystem();
    // world.registerSystem(systemResource, messageSystem, true);
    // world.registerFunctionSelector(systemResource, "mintGold(string)");


    // ResourceId goldToken = WorldResourceIdLib.encodeNamespace("goldToken");
    // ResourceId silverToken = WorldResourceIdLib.encodeNamespace("silverToken");
    // IWorld(worldAddress).transferOwnership(goldToken, worldAddress);
    // console.log("transferOwnership goldToken");
    // IWorld(worldAddress).transferOwnership(silverToken, worldAddress);
    // console.log("transferOwnership silverToken");
    // ------------------ EXAMPLES ------------------

    // Call increment on the world via the registered function selector
    // uint32 newValue = IWorld(worldAddress).app__increment();
    // console.log("Increment via IWorld:", newValue);

  }
}
