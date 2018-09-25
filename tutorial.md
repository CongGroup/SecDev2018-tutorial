# Contract deploy

## Target

Deploy a contract to Ropsten Testnet and make your contract source code public.

## Requirement

1. Install Chrome:  [https://www.google.com/chrome/](https://www.google.com/chrome/)
2. Install MetaMask extension: [https://metamask.io/](https://metamask.io/)



## Step


### Open new version of MetaMask

After installing MetaMask,  you can find MetaMask icon(a fox) on top right.  Click it and try the new MetaMask.

<img src="/Users/anxin/Desktop/tutorial/maskopen.jpg" width="400" />




### Create your account 

**1**.After click continue, it's required to create an account for the first time. 

<img src="/Users/anxin/Desktop/tutorial/newAccount.jpg" width="400" />

**2**.After accepting several statements, you can get your "Secret Backup Phrase". Save it to a convinient place.  Soon we will use it to finish the creation.

> "Secret Backup Phrase" can be used to recover your account. 

<img src="/Users/anxin/Desktop/tutorial/secret phrase.jpg">

### Connect to Ropsten Test Network

Default, we are on "Main Ethereum Network". Switch to "Ropsten Test Network".


<img src="/Users/anxin/Desktop/tutorial/masknetwork.jpg" width="500" />

### Get test ether 

We need ether to send transactions.  Go to [Ropsten Faucet](https://faucet.ropsten.be/). Your account is filled by default.
 Click button and get one ether !
 
> Every day, you can get one ether for your account.  
> One public ip is allowed to do one time in a day.

<img src="/Users/anxin/Desktop/tutorial/getether.jpg" width="500" />

### Open Remix && Connect to Ropsten

**1.**Click [here](https://remix.ethereum.org) to open remix.

> Remix: An online IDE for Solidity(A official programming language for smart contract). We will use it to compile and deploy our smart contract. 

**2.**Click "run" on the right top and change Enviroment to "Injected Web3". We use the configuration of MetaMask, so we connect to Ropsten here.

<img src="/Users/anxin/Desktop/tutorial/connectmetamask.jpg" width="500" />



### Compile contract 

**1.**For the first time, remix will generate a simple "ballot.sol" contract for us. Replace the content with our token contract. Paste following code  to editor:

```  solidity

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
```

**2.**Click compile. It shows the information of compiler. By default, current version is "0.4.25+commit.59dbf8f1.Emscripten.clang" and you don't need change it. In case it's different, you can choose it at the very beginning of dropdown item(show in the second picture below)

**3.**Select enable optimation and start compile
<img src="/Users/anxin/Desktop/tutorial/compile.jpg" width="500" />
<img src="/Users/anxin/Desktop/tutorial/version.jpg", width="400">
 



### Deploy Contract

After compilation, it's time to deploy the contract. Our contract constructor has four arguments:

* Amount of token to supply (uint)
* Name of token		            (string)
* Symbol of token	            (string)
* Token Decimal                   (uint) 

> There is no float type in Solidity now.

Possible arguments: 10000, "DemoToken","DMT", 10

**1.**Input arguments and deploy.


<img src="/Users/anxin/Desktop/tutorial/deploy.jpg" width="500" />


**2.**After clicking deploy, you can see your receipt on the left. Confirm it and waiting for seconds, you contract will be deployed to 

<img src="/Users/anxin/Desktop/tutorial/receipt.jpg" width="400" />


**3.**After a short waiting, you can check your deployed contract. Copy the contract address. We will use it to check our contract status in "Etherscan". **Do not close remix unitl tutorial end !!**


<img src="/Users/anxin/Desktop/tutorial/copy address.jpg" width="400" />


### Make your contract public in Etherscan




**1.**Open [Ropsten Etherscan](https://ropsten.etherscan.io/). Use your contract address to query your contract status. 

> In Etherscan, we can check every transaction and see the source code of every deployed contract. To make your contract reliable for others,  it's best to public your contract.

<img src="/Users/anxin/Desktop/tutorial/ethersan.jpg" width="500" />




**2.**At this moment, you can only see your contract bytecode or opcode. Then click "Verify and Publish" to offer your source code.

<img src="/Users/anxin/Desktop/tutorial/eccode.jpg" width="300" />


**3.**Input your contract name , choose compiler version,  soruce code. Then you can verify and publish your source code.


<img src="/Users/anxin/Desktop/tutorial/publish.jpg" width="500" />



**4.**Now your source code is viewable for everyone.


<img src="/Users/anxin/Desktop/tutorial/sourceCode.jpg" width="500" />
