contract Lottery 
{
    //Data type for a player
    struct Player {
        uint tixNum;
        address playerAddr;
    }

    //Required data 
    Player[] winners;
    uint public startTime;
    uint public endTime; 
    uint winningNumber; //get this number from toto/4D/etc website
    

    function buyLotteryTicket(uint ticketNum) {
        //allows user to buy a lottery number
    } 

    
    function endLottery() {
        //function stub, end the lottery
    }

    function sendMoney() {
        //stub, but you can send money to 
        //someone using the send() function 
        address winner = 0x123; 
        winner.send(10); //10 wei 
    } 

}
