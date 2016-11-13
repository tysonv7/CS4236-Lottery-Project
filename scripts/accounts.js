/*
    Account Management
 */

function createAccount() {
  personal.newAccount("password");
}

function unlockAccount(user) {
  personal.unlockAccount(user, "password");
}

function viewAllAccounts() {
  return eth.accounts;
}
