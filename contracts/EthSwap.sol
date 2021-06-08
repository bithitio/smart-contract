// SPDX-License-Identifier: unlicense
pragma solidity ^0.5.17;

import "./BEP20Token.sol";

contract EthSwap {

  string public name = "BitHit Instant Exchange";
  BEP20Token public token;
  uint public rate;
  address admin;

  event TokensPurchased(
    address account,
    address token,
    uint amount,
    uint rate
  );

  constructor(BEP20Token _token, uint _rate) public {
    token = _token;
    rate = _rate;
    admin = msg.sender;
  }

  function buyTokens() public payable {
    // Calculate the number of tokens to buy
    uint tokenAmount = msg.value * rate;

    // Require that EthSwap has enough tokens
    require(token.balanceOf(address(this)) >= tokenAmount);

    // Transfer tokens to the user
    token.transfer(msg.sender, tokenAmount);

    // Emit an event
    emit TokensPurchased(msg.sender, address(token), tokenAmount, rate);
  }
  
  // Ending TokenSale
    function endSale() public {
    // Require admin
    require(msg.sender == admin,'only admin can end token sale');
    require(token.transfer(admin,token.balanceOf(address(this))),'balance not transferring');
    selfdestruct(msg.sender);
    // Transfer remaining tokens to admin
    // Destroy contract

    }

}
