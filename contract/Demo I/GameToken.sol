pragma solidity ^0.4.25;

import '../utils/BasicToken.sol';

contract GameToken is BasicToken {
    // creator of this contract
    address internal _owner;

    // only authorized game machine can consume and reward user token
    mapping (address => bool) public _authorizdedMachines;
    
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
        require(_authorizdedMachines[msg.sender]);
        _;
    }
    
    function addGameMachine(address machine) public onlyOwner() {
        _authorizdedMachines[machine] = true;
    }
    
    function removeGameMachine(address machine) public onlyOwner() {
        _authorizdedMachines[machine] = false;
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