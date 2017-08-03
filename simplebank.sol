pragma solidity ^0.4.0;

contract SimpleBank {

  mapping (address => uint) balances;

  address public owner;

  event LogDepositMade(address accountAddress, uint amount);
  // publicize actions to external listeners

  function SimpleBank() {
    owner = msg.sender;
    // msg gives us details about the message that's sent to the contract
    // msg.sender is the contract caller (the person who started the contract)
  }

  function deposit() public returns (uint) {
    balances[msg.sender] += msg.value;

    LogDepositMade(msg.sender, msg.value); // fires event made earlier above ^^

    return balances[msg.sender];
  }

  function withdraw(uint withdrawAmount) public returns (uint remainingBalance) {
    if(balances[msg.sender] >= withdrawAmount) {
      balances[msg.sender] -= withdrawAmount;

      if(!msg.sender.send(withdrawAmount)) {
        balances[msg.sender] += withdrawAmount;
      }
    }
    return balances[msg.sender];
  }

  function balance() constant returns (uint) {
    return balances[msg.sender];
  }

  function () {
    throw;
  }
}
