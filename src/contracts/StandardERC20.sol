// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

contract StandardERC20 is ERC20 {
  constructor() public ERC20("testToken", "TST") {
    _mint(msg.sender, 1000000000 * 10**18);
  }

  function mint(address account, uint256 amount)public virtual returns (bool){
    require(account != address(0), "ERC20: mint to the zero address");
    _mint(account, amount * 10**18);
    return true;
  }

  function burn(uint256 amount) public virtual returns (bool) {
        _burn(_msgSender(), amount* 10**18);
        return true;
    }
}
