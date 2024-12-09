// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract TicketBookingSystem {
    address public owner;
    uint public ticketPrice = 1 ether;
    uint public totalTickets;
    uint public ticketsSold;

    mapping(address => uint) public userTickets;

    // Custom error for ticket availability
    error NotEnoughTickets(uint requested, uint available);
    error InsufficientFunds(uint required, uint sent);

    constructor(uint _totalTickets) {
        owner = msg.sender;
        totalTickets = _totalTickets;
        ticketsSold = 0;
    }

    // Function to purchase tickets
    function purchaseTickets(uint _ticketCount) external payable {
        // Ensure user sends sufficient Ether
        require(msg.value >= _ticketCount * ticketPrice, "Insufficient Ether sent for ticket purchase");

        // Check if enough tickets are available
        if (ticketsSold + _ticketCount > totalTickets) {
            revert NotEnoughTickets({
                requested: _ticketCount,
                available: totalTickets - ticketsSold
            });
        }

        // Update tickets sold and assign to user
        ticketsSold += _ticketCount;
        userTickets[msg.sender] += _ticketCount;

        // Refund excess Ether if any
        uint excess = msg.value - (_ticketCount * ticketPrice);
        if (excess > 0) {
            payable(msg.sender).transfer(excess);
        }
    }

    // Function to check user ticket count
    function checkTickets() external view returns (uint) {
        uint tickets = userTickets[msg.sender];
        assert(tickets >= 0); // Internal invariant: tickets must never be negative
        return tickets;
    }

    // Function to request a refund
    function requestRefund(uint _ticketCount) external {
        // Ensure user has enough tickets to refund
        require(userTickets[msg.sender] >= _ticketCount, "You don't have enough tickets to refund");

        // Deduct tickets and refund Ether
        userTickets[msg.sender] -= _ticketCount;
        ticketsSold -= _ticketCount;
        uint refundAmount = _ticketCount * ticketPrice;
        payable(msg.sender).transfer(refundAmount);
    }

    // Function to check the remaining tickets
    function remainingTickets() external view returns (uint) {
        return totalTickets - ticketsSold;
    }

    // Function for the owner to withdraw earnings
    function withdrawEarnings() external {
        require(msg.sender == owner, "Only the owner can withdraw earnings");
        payable(owner).transfer(address(this).balance);
    }
}
