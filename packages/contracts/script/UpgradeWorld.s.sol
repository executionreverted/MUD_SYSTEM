// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;
 
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
 
import { World } from "@latticexyz/world/src/World.sol";
import { WorldProxy } from "@latticexyz/world/src/WorldProxy.sol";
 
contract SetImplementation is Script {
  function run() external {
    uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(deployerPrivateKey);
 
    string memory json = vm.readFile("deploys/31337/latest.json");
    address proxyAddress = abi.decode(vm.parseJson(json, ".worldAddress"), (address));
    // address proxyAddress = vm.envAddress("WORLD_ADDRESS");
 
    // Deploy new world implementation
    World newWorld = new World();
 
    console.log("proxy:", proxyAddress);
    console.log("new World:", address(newWorld));
 
    WorldProxy(payable(proxyAddress)).setImplementation(address(newWorld));
 
    vm.stopBroadcast();
  }
}