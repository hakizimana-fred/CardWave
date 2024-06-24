// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


/**
 * @title CardWave
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */

import {IERC20Token} from "./IERC20I.sol";
 
contract CardWave {
  uint256 public minimumPrice = 5;
  address internal senderAddress;
//   uint256 internal cashback  = 1e18;

  constructor(){
    senderAddress = msg.sender;
  }

     struct Card {
         address senderAddress;
         string name;
         string service;
         uint256 amount;
     }
    mapping (uint => Card) internal cards;
    uint internal nextCardId;
     uint[] internal cardIds;
    event CardCreated(uint cardId, address owner, string name, uint amount);
    event CardRedeemed(uint cardId, address redeemer, uint amount);


  function createCard(string memory name, string memory service, uint256 _amount) public payable {
     // Check if the amount is one of the valid values and meets the minimum price requirement
        require(
            (_amount >= minimumPrice || _amount == 10 || _amount == 15 || _amount == 25 || _amount == 30),
            "Please provide a valid amount"
        );
         cards[nextCardId] = Card(
            msg.sender,
            name,
            service,
            msg.value
        );
        cardIds.push(nextCardId);  // Store the new card ID
        nextCardId++;

    //  payable(msg.sender).transfer(cashback); // give a cashback on every giftcard created. 

   }

  function readGiftCard(uint _index) public view returns (
        address,
        string memory, 
        uint256
    ) {
        return (
            cards[_index].senderAddress,
            cards[_index].name, 
            cards[_index].amount
        );
    }

 function getBalance() public view returns (uint) {
        return msg.sender.balance;
  }
 
    receive() external payable {} 
  
}
