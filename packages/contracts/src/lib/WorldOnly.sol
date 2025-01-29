pragma solidity ^0.8.4;

import { Ownable } from "@solady/auth/Ownable.sol";
import { Initializable } from "@solady/utils/Initializable.sol";

contract WorldOnly is Initializable, Ownable {
  mapping(address => bool) public isSystem;

  function initializeWorldOnly(address owner) internal initializer {
    _initializeOwner(owner);
  }

  function setSystem(address system, bool isAllowed) external onlyOwner {
    isSystem[system] = isAllowed;
  }

  modifier onlyWorld() {
    if (isSystem[msg.sender]) {
      revert("Only the world or a system can call this function");
    }
    _;
  }
}
