// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { ERC20 } from "@solady/tokens/ERC20.sol";
import { WorldOnly } from "./WorldOnly.sol";

contract InGameERC20 is ERC20, WorldOnly {
  string public name$;
  string public symbol$;

  function initialize(address owner, string memory _name, string memory _symbol) external initializer {
    initializeWorldOnly(owner);
    name$ = _name;
    symbol$ = _symbol;
  }

  function mint(address to, uint256 amount) external onlyWorld {
    _mint(to, amount);
  }

  function burn(address from, uint256 amount) external onlyWorld {
    _burn(from, amount);
  }

  /// @dev Returns the name of the token.
  function name() public view override returns (string memory) {
    return name$;
  }

  /// @dev Returns the symbol of the token.
  function symbol() public view override returns (string memory) {
    return symbol$;
  }

  function setName(string memory _name) external onlyOwner {
    name$ = _name;
  }

  function setSymbol(string memory _symbol) external onlyOwner {
    symbol$ = _symbol;
  }
}
