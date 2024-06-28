// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.2 <0.9.0;


/**
 * @title CardWave
 * @dev Store & retrieve value in a variable
 * @custom:dev-run-script ./scripts/deploy_with_ethers.ts
 */


contract GiftCards {
 address public owner;

    struct Giftcard {
        address owner;
        uint value;
 
    }

    mapping (address => uint) balances;
    mapping (string => Giftcard) giftcards; // Use string as the key for giftcards mapping

    event Redeemed(address indexed _by, string _name);
    event Spent(address indexed _by, uint _amount);

    constructor() {
        owner = msg.sender;
    }

    function issue(string memory name, uint value) public {
        require(msg.sender == owner, "Only the owner can issue new giftcards");
        require(value > 0, "Giftcard must have a balance");
        require(giftcards[name].value == 0, "Giftcard already issued");

        giftcards[name] = Giftcard({
            value: value,
            owner: address(0)
        });
    }

    function redeem(string memory name) public payable {
        Giftcard storage giftcard = giftcards[name];

        require(giftcard.value > 0, "Invalid giftcard code");
        require(giftcard.owner == address(0), "Giftcard already redeemed");

        giftcard.owner = msg.sender;
        balances[msg.sender] += giftcard.value;

        uint amountToPay = 0.0001 ether;
        payable(msg.sender).transfer(amountToPay);

        emit Redeemed(msg.sender, name);
    }

    function spend(address payable by, uint amount) public {
        require(msg.sender == owner, "Only the owner can deduct from balance");

        require(address(this).balance >= amount, 'Insufficient contract funds');
        by.transfer(amount);

        emit Spent(by, amount);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

 receive() external payable {}
  
}