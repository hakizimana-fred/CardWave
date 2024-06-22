// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

/**
 * @title Storage
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */
interface IERC20Token {
  function transfer(address, uint256) external returns (bool);
  function approve(address, uint256) external returns (bool);
  function transferFrom(address, address, uint256) external returns (bool);
  function totalSupply() external view returns (uint256);
  function balanceOf(address) external view returns (uint256);
  function allowance(address, address) external view returns (uint256);

  event Transfer(address indexed from, address indexed to, uint256 value);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}


contract CardWave {

    struct Card {
         address payable owner;
         string name;
         uint256 amount;
      
     }

    mapping (uint => Card) internal cards;
    uint internal nextCardId;
     uint[] internal cardIds;
    event CardCreated(uint cardId, address owner, string name, uint amount);
    event CardRedeemed(uint cardId, address redeemer, uint amount);

    // creating a gift card
  
   function createCard(string memory name, uint256 amount) public {
        cards[nextCardId] = Card(
            payable(msg.sender),
            name,
            amount
        );
        cardIds.push(nextCardId);  
        nextCardId++;
    }

    
     function redeemCard(uint cardId, uint256 amount) public {
        Card storage card = cards[cardId];

        require(amount > 0 && amount <= card.amount, "Invalid redeem amount");

        card.amount -= amount;
        // payable(msg.sender).transfer(_amount);

        emit CardRedeemed(cardId, msg.sender, amount);
    }

    function readGiftCards(uint _index) public view returns (
        address payable,
        string memory, 
        uint256
    ) {
        return (
            cards[_index].owner,
            cards[_index].name, 
            cards[_index].amount
        );
    }

     function getAllCardIds() public view returns (uint[] memory) {
        return cardIds;
    }


    function getAllCards() public view returns (Card[] memory) {
        Card[] memory allCards = new Card[](cardIds.length);
        for (uint i = 0; i < cardIds.length; i++) {
            allCards[i] = cards[cardIds[i]];
        }
        return allCards;
    }

    // Allow the contract to receive Ether
    // receive() external payable {}
   
}
