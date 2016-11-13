# A Lottery System in Ethereum

### Overview
We present a blockchain smart-contract based lottery system implemented on
Ethereum. This lottery system enables anyone with an Ethereum account to create
or participate in a lottery securely and anonymously.

An Ethereum user may deploy a lottery contract onto the blockchain and become
the owner of the lottery. Any Ethereum user can then purchase a ticket using
Ether (the cryptocurrency of Ethereum), specifying a particular ticket number.
The Ether goes into a common pool in the lottery contract.

The owner of the lottery can then close the lottery. A winning number is picked
and the prize pool is divided among the winners equally after a chunk is set
aside as the owner's commission. Each winner is then sent his share of the
winnings.

The owner can then destroy the contract and claim his commission.

### The Lottery Contract

```
pragma solidity ^0.4.4;

contract Lottery
{
  struct Player {
    address addr;
    uint tixnum;
  }

  address owner;
  uint pool;
  uint tixPrice;
  uint commission;

  Player[] players;

  function Lottery(uint[2] args) {
    owner       = msg.sender;
    tixPrice    = args[0];
    commission  = args[1];
  }

  function placeBet(uint _tixnum) payable {
    if (msg.value < tixPrice)
      msg.sender.send(msg.value);
    else {
      players.push(Player(msg.sender, _tixnum));
      pool += tixPrice;
      if (msg.value > tixPrice)
        msg.sender.send(msg.value - tixPrice);
    }
  }

  function generateRandomNumber() internal returns (uint) {
    return 8888;
  }

  function closeLottery() {
    if (msg.sender == owner) {
      uint winningnum = 8888;

      pool = pool * (100 - commission) / 100;

      Player[] winners;
      for (uint i = 0; i < players.length; i++) {
        if (players[i].tixnum == winningnum)
          winners.push(players[i]);
      }

      uint prize_per_winner = pool / winners.length;

      for (uint j = 0; j < winners.length; j++) {
        winners[j].addr.send(prize_per_winner);
      }
    }
  }

  function kill() {
    if (msg.sender == owner) selfdestruct(owner);
  }
}
```

### Usage

### Benefits of Our Approach

### Conclusion
