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
import { Systems } from "@latticexyz/world/src/codegen/tables/Systems.sol";
import { ItemList } from "./ItemList.sol";
import { Item, ItemData } from "../src/codegen/tables/Item.sol";
import { ConsumableList } from "./ConsumableList.sol";
import { ConsumableData } from "../src/codegen/tables/Consumable.sol";
import { EquipmentList } from "./EquipmentList.sol";
import { EquipmentData } from "../src/codegen/tables/Equipment.sol";

contract UpgradeTokenMinter is Script {
  function run() external {
    address worldAddress = 0x3d3384D9699c731d64e7F68a05e009e3E6779fF5;
    // Specify a store so that you can use tables directly in PostDeploy
    StoreSwitch.setStoreAddress(worldAddress);

    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    address deployerAddress = vm.envAddress("DEPLOYER_ADDRESS");
    // Start broadcasting transactions from the deployer account
    vm.startBroadcast(deployerPrivateKey);

    ResourceId systemResource = WorldResourceIdLib.encode(RESOURCE_SYSTEM, "app", "TokenMinter");
    (address mySys, ) = Systems.get(systemResource);
    console.log("Deployed Minter System address");
    console.log(mySys);

    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("gold"));
    IWorld(worldAddress).grantAccess(namespaceResource, mySys);

    ResourceId namespaceResource2 = WorldResourceIdLib.encodeNamespace(bytes14("silver"));
    IWorld(worldAddress).grantAccess(namespaceResource2, mySys);

    ResourceId namespaceResource3 = WorldResourceIdLib.encodeNamespace(bytes14("items"));
    IWorld(worldAddress).grantAccess(namespaceResource3, mySys);

    vm.stopBroadcast();
  }
}
