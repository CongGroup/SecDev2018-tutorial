pragma solidity ^0.4.25;

import './SafeMath.sol';

contract BasicToken {
    using SafeMath for uint256;
    
    uint256 internal _totalSupply;

    string public name;

    uint8 public decimals;

    string public symbol;

    mapping (address => uint256) internal _balances;

    mapping (address => mapping (address => uint256)) internal _allowed;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    constructor (
        uint256 totalSupply,
        string tokenName,
        string tokenSymbol,
        uint8 decimalUnits
    ) public {
        _totalSupply = totalSupply;
        _balances[msg.sender] = totalSupply;
        name = tokenName;
        decimals = decimalUnits;
        symbol = tokenSymbol;
    }
    
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    
    function balanceOf(address owner) public view returns (uint256) {
        return _balances[owner];
    }
    
    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowed[owner][spender];
    }
    
    function _transfer(address from, address to, uint256 value) internal {
        require(value <= _balances[msg.sender]);
        require(to != address(0));
        
        _balances[from] = _balances[from].sub(value);
        _balances[to] = _balances[to].add(value);
    }
    
    function transfer(address to, uint256 value) public returns (bool) {
        _transfer(msg.sender, to, value);
        emit Transfer(msg.sender, to, value);
        return true;
    }

    function approve(address spender, uint256 value) public returns (bool) {
        require(spender != address(0));

        _allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }
    
    function transferFrom(address from, address to, uint256 value) public returns (bool) {
        require(value <= _allowed[from][msg.sender]);
        _allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        
        _transfer(from, to, value);
        emit Transfer(from, to, value);
        return true;
    }
}