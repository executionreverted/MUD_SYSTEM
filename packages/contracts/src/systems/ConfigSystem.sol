// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { System } from "@latticexyz/world/src/System.sol";
import { Config } from "../codegen/index.sol";
import { console } from "forge-std/console.sol";

error OnlyAdmin();
error AdminAddressAlreadySet();

contract ConfigSystem is System {
  
  modifier onlyAdmin() {
    console.log("Sender:", _msgSender());
    if (_msgSender() != Config.getAdminAddress()) revert OnlyAdmin();
    _;
  }

  function setAdminAddress(address _adminAddress) external {
    if (Config.getAdminAddress() != address(0)) revert AdminAddressAlreadySet();

    Config.setAdminAddress(_adminAddress);
  }

  function setPaused(bool _paused) external onlyAdmin {
    Config.setPaused(_paused);
  }
}
