pragma solidity ^0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { ERC20Registry } from "@latticexyz/world-module-erc20/src/codegen/index.sol";
import { ERC20WithWorld as ERC20 } from "@latticexyz/world-module-erc20/src/examples/ERC20WithWorld.sol";
import { console } from "forge-std/console.sol";

contract TokenMinterSystem is System {
  function mintGold(address to, uint256 amount) external {
    // Table Id of the ERC20Registry, under the `erc20-module` namespace
    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("goldToken"));
    ResourceId erc20RegistryResource = WorldResourceIdLib.encode(RESOURCE_TABLE, "erc20-module", "ERC20_REGISTRY");
    address tokenAddress = ERC20Registry.getTokenAddress(erc20RegistryResource, namespaceResource);

    console.log(tokenAddress);
    ERC20 erc20 = ERC20(tokenAddress);
    erc20.mint(to, amount);
  }

  function mintSilver(address to, uint256 amount) external {
    // Table Id of the ERC20Registry, under the `erc20-module` namespace
    // ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("silverToken"));
    // ResourceId erc20RegistryResource = WorldResourceIdLib.encode(RESOURCE_TABLE, "erc20-module", "ERC20_REGISTRY");
    // address tokenAddress = ERC20Registry.getTokenAddress(erc20RegistryResource, namespaceResource);

    // ERC20 erc20 = ERC20(tokenAddress);
    // erc20.mint(to, amount);
  }
}
