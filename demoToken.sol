pragma solidity ^0.4.21;

contract demoToken {

    struct GameMachine {
        mapping(address => bool) bearer;
    }
    
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;
    string public name;                   //Token name
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier
    uint256 public totalSupply;
    address public owner;
    GameMachine gameMachine;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    constructor (
        uint256 _initialAmount,
        string _tokenName,
        string _tokenSymbol,
        uint8 _decimalUnits
    ) public {
        owner = msg.sender;                                  // creator
        balances[msg.sender] = _initialAmount;               // Give the creator all initial tokens
        totalSupply = _initialAmount;                        // Update total supply
        name = _tokenName;                                   // Set the name for display purposes
        decimals = _decimalUnits;                            // Amount of decimals for display purposes
        symbol = _tokenSymbol;                               // Set the symbol for display purposes
    }
    
    modifier onlyOwner()  {
        require(msg.sender == owner);
        _;
    }
    
    modifier isGameMachine()  {
        require(gameMachine.bearer[msg.sender]);
        _;
    }
    
    function addGameMachine(address account) public onlyOwner() {
        gameMachine.bearer[account] = true;
    }
    
    function removeGameMachine(address account) public onlyOwner() {
        gameMachine.bearer[account] = false;
    }
    
    function mint(address account, uint256 amount) public isGameMachine() returns (bool success) {
        totalSupply += amount;
        balances[account] += amount;
        emit Transfer(address(0), account, amount);
        return true;
    }
    
    function burn(uint256 amount) public isGameMachine() returns (bool success) {
        require(amount <= balances[msg.sender]);
        totalSupply -= amount;
        balances[msg.sender] -=amount;
        emit Transfer(msg.sender, address(0), amount);
        return true;
    }

    function transfer(address account, uint256 value) public returns (bool success) {
        require(balances[msg.sender] >= value);
        balances[msg.sender] -= value;
        balances[account] += value;
        emit Transfer(msg.sender, account, value); 
        return true;
    }

    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
        uint256 allowance = allowed[from][msg.sender];
        require(balances[from] >= value && allowance >= value);
        balances[to] += value;
        balances[from] -= value;
        if (allowance < MAX_UINT256) {
            allowed[from][msg.sender] -= value;
        }
        emit Transfer(from, to, value); 
        return true;
    }

    function balanceOf(address _owner) public view returns (uint256 balance) {
        return balances[_owner];
    }

    function approve(address spender, uint256 value) public returns (bool success) {
        allowed[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value); 
        return true;
    }

    function allowance(address _owner, address spender) public view returns (uint256 remaining) {
        return allowed[_owner][spender];
    }
}