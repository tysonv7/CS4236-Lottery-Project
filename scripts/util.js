function getEtherBalance(user) {
  return web3.fromWei(eth.getBalance(user), "ether");
}

function sendEther(fromUser, toUser, amount) {
  eth.sendTransaction({from: fromUser, to: toUser, value: web3.toWei(amount, "ether")});
}

function setEtherBase(user) {
  miner.setEtherbase(user);
}
