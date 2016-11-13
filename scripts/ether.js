/*
    Ether Management
 */

function getEtherBalance(user) {
  return web3.fromWei(eth.getBalance(user), "ether");
}

function getAllEtherBalance() {
  for (var i = 0; i < eth.accounts.length; i++) {
    console.log("Account " + i + " balance: " + getEtherBalance(eth.accounts[i]));
  }
}

function sendEther(fromUser, toUser, amount) {
  eth.sendTransaction({from: fromUser, to: toUser, value: web3.toWei(amount, "ether")});
}

function e2w(x) {
  return web3.toWei(x, "ether");
}
