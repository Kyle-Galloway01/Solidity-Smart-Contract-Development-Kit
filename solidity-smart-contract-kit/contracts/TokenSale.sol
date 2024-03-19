pragma solidity ^0.8.0;

import "./Token.sol";

contract TokenSale {
    Token public tokenContract;
    address payable public owner;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address indexed buyer, uint256 indexed amount);

    constructor(Token _tokenContract, uint256 _tokenPrice) {
        owner = payable(msg.sender);
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == _numberOfTokens * tokenPrice, "Incorrect amount sent");
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens, "Insufficient tokens for sale");

        tokensSold += _numberOfTokens;
        require(tokenContract.transfer(msg.sender, _numberOfTokens), "Token transfer failed");

        emit Sell(msg.sender, _numberOfTokens);
    }

    function endSale() public {
        require(msg.sender == owner, "Only owner can end sale");
        require(tokenContract.transfer(owner, tokenContract.balanceOf(address(this))), "Token transfer failed");

        // Transfer ether balance to owner
        owner.transfer(address(this).balance);
    }
}
