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
    if (msg.value < tixPrice) msg.sender.send(msg.value);
    else {
      players.push(Player(msg.sender, _tixnum));
      pool += tixPrice;
      if (msg.value > tixPrice) msg.sender.send(msg.value - tixPrice);
    }

    if (players.length > 100) closeLottery();
  }

  function generateRandomNumber() internal returns (uint) {
    return 8888;
  }

  function closeLottery() internal {
    uint winningnum = generateRandomNumber();

    Player[] winners;
    for (uint i = 0; i < players.length; i++) {
      if (players[i].tixnum == winningnum) winners.push(players[i]);
    }

    if (players.length > 100 && winners.length > 0) {
      pool = pool * (100 - commission) / 100;
      uint prize_per_winner = pool / winners.length;

      for (uint j = 0; j < winners.length; j++) {
        winners[j].addr.send(prize_per_winner);
      }

      selfdestruct(owner);
    }
  }
}
