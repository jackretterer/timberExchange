pragma solidity ^0.6.0;

import "./Token.sol";
import "./SafeMath.sol";
import "./ERC20.sol";

contract DEX {

    event Bought(uint256 amount);
    event Sold(uint256 amount);

    IERC20 public token;

    constructor() public {
        token = new Token();
    }

    function buy(uint256 amount) payable public {
        // uint256 amountTobuy = msg.value;
        uint256 dexBalance = token.balanceOf(address(this));
        // require(amountTobuy > 0, "You need to send some ether");
        require(amount <= dexBalance, "Not enough tokens in the reserve");
        token.transfer(0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2, amount);
        emit Bought(amount);
    }

    function sell(uint256 amount) public {
        require(amount > 0, "You need to sell at least some tokens");
        uint256 allowance = token.allowance(msg.sender, address(this));
        // require(allowance >= amount, "Check the token allowance");
        token.transferFrom(msg.sender, address(this), amount);
        msg.sender.transfer(amount);
        emit Sold(amount);
    }

}