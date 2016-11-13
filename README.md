# A Lottery System in Ethereum

## Overview
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

## The Lottery Contract
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

## Usage
A script _start.sh_ is provided to enable easy creation of a test blockchain.
The file _CustomGenesis.json_ contains parameters to be supplied when creating
the blockchain. Adjust the parameters if necessary (especially the block gas
limit), and then run `./start.sh init CustomGenesis.json` to initialise the
blockchain.

Ethereum can then be started using `./start.sh console`. If a node is already
running, it is possible to attach to it using
`./start.sh attach ipc:blockchain_data/geth.ipc` instead. Typically, one will
start the console and start the miner in one shell, then attach to that console
in another shell to interact with it. This reduces the need for repeatedly
starting and stopping the miner while experimenting with the contract.

Many utility functions are provided in the _script/_ directory, and all can be
loaded into the Ethereum console with `loadScript('init.js')`.

One may compile the contract with `var contracts = compile("...");` and then
deploy with `var lottery = deploy(contracts.Lottery, account_to_deploy_from);`.
Assuming the miner is running, the contract will soon be inserted into the
blockchain and acquire an address. If the contract is already deployed at a
known address, it may be retrieved with
`getContract(contracts.Lottery, known_address_of_contract);`.

A script _prepare_contract.sh_ is provided to help strip newlines from the
contract to enable insertion into the `compile` function.

## Benefits of Our Approach
The blockchain-based approach to lottery systems yields many benefits over
simply hosting a lottery website and using existing mechanisms to transfer
money to buy tickets. The benefits may be summed up as follows:
* Anonymity
* Reduced Trust Requirement in Lottery Owner
* Non-Repudiation of Ticket Purchase

We address each of these in turn.

### Anonymity
On a traditional client-server-based lottery website, one first needs to
authenticate oneself in order to purchase a lottery ticket. One then needs to
pay for the ticket using traditional payment mechanisms like credit cards.
Upon winning, one certainly needs to authenticate oneself before collecting the
prize money.

At every stage, there is no expectation of anonymity in a traditional site.
This may be highly undesirable due to the social stigma associated with
gambling and the envy of one's peers (with potentially devastating
consequences).

Using Ethereum, the only requirement to participate in the lottery is an
Ethereum address. While the potential for deanonymisation remains if the
Ethereum address is carelessly associated with the user's real identity, it is
very much possible to maintain anonymity with an Ethereum address. Ethereum
users can thus anonymously buy tickets, and even anonymously set up lotteries,
as long as they take care to dissociate their real identities from their
Ethereum address.

### Reduced Trust in Lottery Owner
In a traditional client-server-based lottery website, it may be difficult to
trust the party maintaining the website. A malicious lottery-site owner has
many means to cheat the players of their money.

In the most extreme case, after accepting money for purchase of lottery tickets,
the owner can simply shut down the site and disappear with the money, leaving
little recourse for the victims especially if they are located in a different
country.

Alternatively, the owner can select a winning number to give an unfair advantage
to some player in the lottery.

The problem is that, in the traditional website, the lottery owner has full
control over any state in the server, and can modify it in any way. This
requires players to trust that the owner will not undertake any malicious
activity.

Using Ethereum allows players to do away with trust in the owner, as the
owner does not have any special privileges once the contract is created. A
player can check the contract's code to make sure that the owner has not
inserted any backdoors to enable malicious state changes. The player can then
be convinced that the contract does exactly what it specifies, and this is
verified each time a transaction is made and a block is mined.

The entire code
and specifications of the contract are laid bare on the blockchain for all to
see, allowing players to confidently purchase tickets without having to
worry about a fraudulent owner.

### Non-Repudiation of Ticket Purchase
On the other hand, a traditional client-server based lottery website enables
a user to claim he has not purchased a ticket even though he has, or to claim
that he has purchased a different ticket from what the website has shown. The
player may claim that the owner of the website has changed his ticket number,
or defrauded him in some similar manner.

These claims can be made as the state of the lottery system is entirely under
the owner's control and the owner may plausibly have made the alleged changes.

With Ethereum, a player's ticket purchase is recorded indelibly in the
blockchain, and the player cannot deny having purchased a particular ticket
number or claim to have purchased a different ticket number.


## Conclusion
We have thus seen how blockchain-based lotteries have several advantages over
their traditional counterparts. Their decentralised and anonymous nature
allows them to maintain a permanent, indelible record of all transactions
(barring an attack on Ethereum itself, such as through a 51% attack), while
allowing players to keep their identities hidden. An incorruptible, mechanical
third party in the form of the contract itself allows players and lottery
owners to not have to worry about being defrauded.

Smart contracts on Ethereum may indeed herald a new age of privacy, especially
when government and corporate surveillance of individuals is reaching its peak.
