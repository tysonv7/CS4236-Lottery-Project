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
The lottery contract's constructor accepts a single argument `uint[2] args`,
where `uint[0]` is the ticket price and `uint[1]` is the commission of the
owner (expressed as an integer from `0` to `100` representing how many percent
commission the owner takes). Upon deploying the contract, these parameters are
fixed and cannot be changed by anyone, not even the owner.

The lottery contract has a method called `placeBet(uint _tixnum)`. Anyone
with an Ethereum account wishing to participate in the lottery simply sends
a transaction from his account to the lottery contract, including in the
transaction an amount of Ether sufficient to pay the ticket fees. The account
holder is then registered as a player and any excess Ether sent is refunded.
If the amount of Ether sent is not sufficient to pay the transaction fees, the
account holder is not registered in the lottery and all the Ether sent is
refunded. The Ether sent to the contract is tracked in the `pool` variable.

The lottery contract has a method called `closeLottery()`. This method, which
is only executed if the caller is the contract owner, picks a winning number.
The winners are then selected from all the players, by checking who purchased
a ticket with the winning number (there may be more that one person who
purchased the ticket with the winning number, and hence more than one winner).
The prize pool is (after setting aside the commission amount for the owner)
divided equally and sent to all the winners.

The lottery contract has a method called `kill()`, which is only executed if
the caller is the owner. The method destroys the contract using Ethereum's
`selfdestruct` mechanism and passes the commission to the winner.

The full lottery contract is presented below:
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
