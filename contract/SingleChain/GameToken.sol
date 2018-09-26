pragma solidity ^0.4.25;

import '../utils/BasicToken.sol';
import '../utils/Helpers.sol';

contract GameToken is BasicToken {
    
    address internal _owner;

    address [] internal _authorizdedMachines;
    
    event Reward(address indexed machine, address indexed player, uint256 value);
    event Consume(address indexed machine, address indexed player, uint256 value);

    constructor (
        uint256 totalSupply,
        string tokenName,
        string tokenSymbol,
        uint8 decimalUnits
    ) BasicToken(totalSupply,tokenName,tokenSymbol,decimalUnits) public {
        _owner = msg.sender;
    }

    modifier onlyOwner()  {
        require(msg.sender == _owner);
        _;
    }
    
    modifier onlyAuthorizedMachine()  {
        require(Helpers.addressArrayContains(_authorizdedMachines, msg.sender));
        _;
    }
    
    function addGameMachine(address machine) public onlyOwner() {
        _authorizdedMachines.push(machine);
    }
    
    function removeGameMachine(address machine) public onlyOwner() {
        int index = Helpers.indexOfElement(_authorizdedMachines, machine);
        if (index!=-1){
            uint len = _authorizdedMachines.length;
            _authorizdedMachines[uint(index)] = _authorizdedMachines[len - 1];
            delete _authorizdedMachines[len - 1];
        }
    }
    
    function reward(address to, uint256 value) public onlyAuthorizedMachine() returns (bool) {
        _transfer(msg.sender, to, value);
        emit Reward(msg.sender, to, value);
        return true;
    }
    
    function consume(address by, uint256 value) public onlyAuthorizedMachine() returns (bool){
        _transfer(by, msg.sender, value);
        emit Consume(msg.sender, by, value);
        return true;
    }
}