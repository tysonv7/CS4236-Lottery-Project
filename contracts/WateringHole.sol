contract WateringHole {
    mapping (address => uint) public numbers;
    address bartender;

    uint x;
    function(){ x = 1; }

    function WateringHole() { bartender = msg.sender; }
    function kill() { if (msg.sender == bartender) selfdestruct(bartender); }

    function set(uint n) { numbers[msg.sender] = n; }
    function get() constant returns (uint) { return numbers[msg.sender]; }
}
