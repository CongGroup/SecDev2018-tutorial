pragma solidity ^0.4.18;

import '../SingleChain/GameToken.sol';

contract BridgeToken is GameToken{

    mapping (bytes32 => bool) public payed;
    uint256 public requiredSignatures;
    
    event Exchange(address indexed user, uint amount);
    event Pay(address user, uint amount ,bytes32 transactionHash);

    constructor (uint256 totalSupply,
                string tokenName,
                string tokenSymbol,
                uint8 decimalUnits, 
                uint _requiredSignatures) 
    public GameToken(totalSupply,tokenName,tokenSymbol,decimalUnits) {
        requiredSignatures = _requiredSignatures;
        _owner = msg.sender;

    }

    function setRequiredSignatures(uint newRequiredSignatures) public onlyOwner(){
        requiredSignatures = newRequiredSignatures;
    }

    function exchange(uint amount) public{
        _transfer(msg.sender, _owner, amount);
        emit Exchange(msg.sender, amount);
    }
    
    function pay(uint8 []vs, bytes32 []rs, bytes32 []ss, bytes message) public{
        require(message.length == 84);
        // check that at least `requiredSignatures` `authorities` have signed `message`
        require(Helpers.hasEnoughValidSignatures(message, vs, rs, ss, _authorizdedMachines, requiredSignatures));
        address recipient = Message.getRecipients(message);
        uint256 value = Message.getValues(message);
        bytes32 hash = Message.getTransactionHash(message);
        require(!payed[hash]);
        // Order of operations below is critical to avoid TheDAO-like re-entry bug
        payed[hash] = true;
        _transfer(_owner, recipient, value);
        // pay out recipient
        emit Pay(recipient, value, hash);
    }
}