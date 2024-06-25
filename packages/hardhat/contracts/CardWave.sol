// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


/**
 * @title CardWave
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */

 interface IERC20 {
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
  uint256 public minimumPrice = 5;
  address internal senderAddress;
  IERC20 public cusdToken;
  address internal cusdTokenAddress = 0x874069Fa1Eb16D44d622F2e0Ca25eeA172369bC1; // cUSD contract address on Celo Alfajores testnet

  constructor(){
    senderAddress = msg.sender;
    cusdToken = IERC20(cusdTokenAddress);
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

   event createdCard(string);

  function createCard(string memory _name, string memory _service, uint256 _amount, address _testAdress) public payable {
     // Check if the amount is one of the valid values and meets the minimum price requirement
        require(
            (_amount >= minimumPrice || _amount == 10 || _amount == 15 || _amount == 25 || _amount == 30),
            "Please provide a valid amount"
        );
        
        require(msg.sender == senderAddress, "You must be the owner of this contract");
         cards[nextCardId] = Card(
            msg.sender,
            _name,
            _service,
            msg.value
        );
        cardIds.push(nextCardId);  // Store the new card ID
        nextCardId++;
      emit createdCard("You have successfully created card");
     // payable(msg.sender).transfer(cashback); // give a cashback on every giftcard created. 
     cusdToken.transferFrom(msg.sender, _testAdress, _amount);
      
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

     // redeem  Card
       function redeemCard(uint _cardId, uint256 _amount) public {
        Card storage card = cards[_cardId];

        require(_amount > 0 && _amount <= card.amount, "Invalid redeem amount");

        card.amount -= _amount;
        payable(msg.sender).transfer(_amount);
        emit CardRedeemed(_cardId, msg.sender, _amount);
    }
  // Send to business
  function sendToBusiness(uint256 _amount, address _businessAddress) public payable  {
    payable(_businessAddress).transfer(_amount);

  }

 function getBalance() public view returns (uint) {
        return msg.sender.balance;
  }
 
    receive() external payable {} 
  
}