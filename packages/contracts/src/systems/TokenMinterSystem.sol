// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { System } from "@latticexyz/world/src/System.sol";
import { ResourceId } from "@latticexyz/store/src/ResourceId.sol";
import { RESOURCE_TABLE } from "@latticexyz/store/src/storeResourceTypes.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { ERC20Registry } from "@latticexyz/world-module-erc20/src/codegen/index.sol";
import { ERC20WithWorld as ERC20 } from "@latticexyz/world-module-erc20/src/examples/ERC20WithWorld.sol";
import { ERC721Registry } from "@latticexyz/world-modules/src/modules/erc721-puppet/tables/ERC721Registry.sol";
import { IERC721Mintable } from "@latticexyz/world-modules/src/modules/erc721-puppet/IERC721Mintable.sol";
import { LastAction } from "../codegen/tables/LastAction.sol";
contract TokenMinterSystem is System {
  function mintGold(address to, uint256 amount) external {
    _mintGold(to, amount);
  }

  function _mintGold(address to, uint256 amount) internal {
    address tokenAddress = _getGoldAddress();
    ERC20 erc20 = ERC20(tokenAddress);
    erc20.mint(to, amount);
    LastAction.set(to, block.timestamp);
  }

  function getGoldAddress() external view returns (address) {
    return _getGoldAddress();
  }

  function getSilverAddress() external view returns (address) {
    return _getSilverAddress();
  }

  function _getGoldAddress() internal view returns (address) {
    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("gold"));
    ResourceId erc20RegistryResource = WorldResourceIdLib.encode(RESOURCE_TABLE, "erc20-module", "ERC20_REGISTRY");
    address tokenAddress = ERC20Registry.getTokenAddress(erc20RegistryResource, namespaceResource);
    return tokenAddress;
  }

  function _getSilverAddress() public view returns (address) {
    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("silver"));
    ResourceId erc20RegistryResource = WorldResourceIdLib.encode(RESOURCE_TABLE, "erc20-module", "ERC20_REGISTRY");
    address tokenAddress = ERC20Registry.getTokenAddress(erc20RegistryResource, namespaceResource);
    return tokenAddress;
  }

  function mintSilver(address to, uint256 amount) external {
    _mintSilver(to, amount);
  }

  function _mintSilver(address to, uint256 amount) internal {
    address tokenAddress = _getSilverAddress();
    ERC20 erc20 = ERC20(tokenAddress);
    erc20.mint(to, amount);
    LastAction.set(to, block.timestamp);
  }

  function mintItem(address to, uint256 id) external {
    _mintItem(to, id);
  }

  function _mintItem(address to, uint256 id) internal {
    address tokenAddress = _getItemsAddress();
    IERC721Mintable erc721 = IERC721Mintable(tokenAddress);
    erc721.mint(to, id);
    // LastAction.set(to, block.timestamp);
  }

  function getItemsAddress() external view returns (address) {
    return _getItemsAddress();
  }

  function _getItemsAddress() internal view returns (address) {
    ResourceId namespaceResource = WorldResourceIdLib.encodeNamespace(bytes14("items"));
    ResourceId erc721RegistryResource = WorldResourceIdLib.encode(RESOURCE_TABLE, "erc721-puppet", "ERC721Registry");
    address tokenAddress = ERC721Registry.getTokenAddress(erc721RegistryResource, namespaceResource);
    return tokenAddress;
  }

  function mintAll(address to, uint256 amount) external {
    _mintGold(to, amount);
    _mintSilver(to, amount);
  }
}
