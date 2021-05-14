// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract StandardERC20 is ERC20, AccessControl,ERC20Burnable {
     using SafeMath for uint256;

  uint256 public _maxSupply = 0;
  uint256 public _totalSupply = 0;
  
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");


  constructor() public ERC20("testToken", "TST") {
    _maxSupply = 10000000000 * 10**18;
    _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    _setupRole(MINTER_ROLE, msg.sender);
    _setupRole(BURNER_ROLE, msg.sender);
  }

  function mint(address account, uint256 amount) public virtual returns (bool) {
    require(account != address(0), "ERC20: mint to the zero address");
    require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a burner");
    uint256 newMintSupply = _totalSupply.add(amount * 10**18);
    require(newMintSupply <= _maxSupply, "supply is max!");
    _mint(account, amount * 10**18);
    _totalSupply = _totalSupply.add(amount * 10**18);

    return true;
  }

  function burn(uint256 amount) public virtual override{
    require(hasRole(BURNER_ROLE, msg.sender), "Caller is not a burner");
    uint256 newBurnSupply = _totalSupply.sub(amount * 10**18);
    require(newBurnSupply >= 0, "Can't burn more!");
    _totalSupply = _totalSupply.sub(amount * 10**18);
    _burn(_msgSender(), amount * 10**18);
  }
}
