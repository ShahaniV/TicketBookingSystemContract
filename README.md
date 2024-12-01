# TicketBookingSystem_ETH-AVAX_Vicio  
A simple Solidity smart contract to simulate a ticket booking system where users can buy tickets, cancel bookings, and receive refunds, while leveraging Ethereum's error-handling mechanisms.  

## Description  
This Solidity smart contract demonstrates the use of `require()`, `assert()`, and `revert()` statements for error handling, validating user input, and maintaining logical consistency. It provides a real-life scenario for managing ticket sales and cancellations, making it easy to understand Ethereum's smart contract functionalities.  

## Features  

- **require()**: Validates conditions like ensuring tickets are available and payments meet the required Ether price.  
- **assert()**: Ensures internal consistency, like checking ticket availability.  
- **revert()**: Reverts transactions with a custom error when cancellation is attempted by non-ticket holders.  
- Maintains transparency by storing buyer details and refunds Ether upon cancellations.  

## Executing Program  

1. **Compile the Contract**: Open the contract in Remix Ethereum IDE and ensure Solidity version `^0.8.18` is selected.  
2. **Deploy the Contract**: Use the Remix local VM or connect to a testnet to deploy the contract.  
3. **Test the Contract**:  
   - Call `purchaseTicket()` and send 0.2 Ether. Verify the ticket owner is updated.  
   - Call `cancelBooking()` as the ticket owner to refund Ether.  
   - Attempt invalid scenarios (e.g., insufficient Ether or non-owner cancellation) to trigger error messages.  

## Help  

### Common Issues  
- If you cannot send 0.2 Ether, ensure the value is entered in **ETH** and not in **wei** (use `0.2` directly in the "Value" field).  
- Ensure you have enough test Ether in your connected wallet for testing on a testnet.  
- If the contract doesn't compile, verify the Solidity version is compatible.  

## Author  

Shahani Fe D. Vicio | 202110931@fit.edu.ph  
