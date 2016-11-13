contract Bank {
    mapping (address => uint) public balances;
    address owner;

    function(){}
    function Bank() { owner = msg.sender; }
    function kill() { if (msg.sender == owner) selfdestruct(owner); }

    function deposit() payable { balances[msg.sender] += msg.value; }
    function withdraw(uint amt) payable { balances[msg.sender] -= amt; msg.sender.send(amt); }
}
