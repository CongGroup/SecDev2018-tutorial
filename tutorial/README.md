# Tutorial

## Overview 

This tutorial includes three part: *Deploy and Make Contract Public*, *From contract to a web app*, and *Appendix*. Part one is about deploying a contract in public ethereum testnet. Part two elaborates on our demo on the basis of this contract and summarizes all the important notes. Part three introduces all the programming tools used.

## Deploy and Make Contract Public

### 1. Introduction

In this part, [*Kovan Etherscan*](https://kovan.etherscan.io/) (One of ethereum testnet) is used for contract deployment. Before the actual deployment, it is required to install [chrome](https://www.google.com/chrome/) and [Metamask](https://metamask.io/) extension. With *Metamask* (a pretty GUI), you don't have to run your own node. See details below.

### 2.  Open Metamask

After installing MetaMask, you can find MetaMask icon (a fox) on top right. Click it. For consideration of compatibility issues, please try the new version of *MetaMask*.


<center><img style="text-align:center" src="assets/maskopen.jpg" width="250" /></center>




### 3. Create your account 

1. Click continue, please follow the instructions to create an account. 

<center><img src="assets/newAccount.jpg" width="250" /></center>

1. After a few simple steps, you will see the "Secret Backup Phrase". Save it to a 
convenient place.  Soon we will use it to finish the creation.

> "Secret Backup Phrase" can be used to recover your account. 

<center><img src="assets/secret phrase.jpg" width="300"></center>

### Connect to Kovan Test Network

By default, "Main Ethereum Network" is used for contract deployment. Switch to "Kovan Test Network".


<center><img src="assets/masknetwork.jpg" width="600" /></center>

### 4. Get test ether 

For convinience, you can visit this [Demo Faucet](http://private.secdevgame.site/#/faucet) to get 0.01 ether for test. Or you can visit [Kovan faucet](https://gitter.im/kovan-testnet/faucet), send out your address and wait for administrator to give you 3 ether.

<center><img src="assets/getEther.png" width="700" /></center>



### 5.Open Remix && Connect to Kovan

1. Click [here](https://remix.ethereum.org) to open remix. 
> Remix is an online IDE for Solidity(A official programming language for smart contract). It is quite easy to use Remix for contract compilation and deployment . 

2. Click *Run* on the right top and alter the Enviroment to "Injected Web3". As we are using *Metamask*, we connect to Kovan here.

<center><img src="assets/connectmetamask.jpg" width="400" /></center>



### 6.Compile contract 

1. For the first time, remix will generate a simple "ballot.sol" contract for us. Replace the content with our token contract. And then paste our demo code to the editor. You can find the code [here].(https://github.com/CongGroup/SecDev2018-tutorial/blob/master/contract/DemoToken.sol)


2. Click compile. It displays all the information of the compiler. By default, the current version is "0.4.25+commit.59dbf8f1.Emscripten.clang" and you don't have to change it. In case it's different, you can choose it at the very beginning of dropdown item (show in the second picture below).

3. Select "Enable Optimation" and click "Start to compile"
<center><img src="assets/compile.jpg" width="500" /> </center>

Note: Check the following image if your have trouble following step 2 in this session.
<center> <img src="assets/version.jpg", width="400"> </center>
 



### 7. Deploy Contract

After compilation, it's time to deploy the contract. The contract constructor has four arguments:

* Amount of token to supply (uint)
* Name of token		            (string)
* Symbol of token	            (string)
* Token Decimal                   (uint). As there is no **float** type now, your may need define decimal.


Possible arguments: 10000, "DemoToken","DMT", 10

1. Input the example arguments and click "Deploy".


<center><img src="assets/deploy.jpg" width="500" /></center>


2. Now you can see your receipt on the left of the screen. Confirm it and waiting for several seconds, your contract will be deployed.

<center><img src="assets/receipt.jpg" width="300" /></center>


3. After a short while, you can check your deployed contract. Please copy the contract address. Later it can be used to check your contract status in "Etherscan". **Do not close remix until this part end !!**


<center><img src="assets/copyAddress.jpg" width="500" /></center>


### 8. Make your contract public in Etherscan




1. Open [Kovan Etherscan](https://kovan.etherscan.io/). Use your contract address to query your contract status. 

> In Etherscan, you can check every transaction and see the source code of every deployed contract. To make your contract reliable for others, it's better to publish your contract.

<center><img src="assets/getEther.png" width="800" /></center>




1. At this moment, you can only see your contract bytecode or opcode. Click "Verify and Publish" to publish your source code.

<center><img src="assets/eccode.jpg" width="800" /></center>


3. Input your contract name, choose the compiler version and the soruce code. Then you can verify and publish your source code.


<center><img src="assets/publish.jpg" width="800" /></center>



4. Now your source code is viewable for everyone.


<center><img src="assets/sourceCode.jpg" width="800" /></center>


## From contract to a web app

### 1. Introduction

In this part, detailed explanation of the demo is provided. There are altogether two versions of demo. One is built on the public chain while the other is built on the private chain and the public chain. The functions of the former version is included in the latter version. After going through the former version, you can have a better understanding upon why we use the private chain here. 

The former version is [here](http://public.secdevgame.site), which is built on the public chain

The latter version is [here](http://private.secdevgame.site), which is built on the private chain and the public chain.

In addition, important notes of implementing such a demo in general are summarized.

### 2. Demo Show


1.For the first time you don't have an account, so create your account and sign in. Your generated account will be stored in browser cookie. If you want to sign in again with the same account, you may need to enable cookie in your browser.

<center> <img src="assets/signin.png" width=300> </center>
	
<center> <img src="assets/welcome.png" width=300> </center>

2.At the top of web page, you can see our navigation bar, including *Game Machine*, *Wallet*, *Faucet*.

<center> <img src="assets/nav.png" width=500> </center> 

3.Go to our faucet and get 0.01 ether for test.

<center> <img src="assets/faucet.png" width=500> </center>

4.Now you can start to play game machine! Input your wager amount and run the slotmachine. After 4 rounds, you will get one token for reward.

<center> <img src="assets/slotmachine.png" width=500> </center>

4.Consume 2 tokens, you can get into a *Double* state, where after 4 rounds, your reward will double.

<center> <img src="assets/double.png" width=500> </center>

5.(This part is only shown in the latter version) Look into the wallet, you can transfer your token between the private chain and the public chain. After input the amount of token to transfer, click the *exchange* button , you will send a transaction signed by your account to our server which transfer the transaction to chain . After waiting for seconds, you can see your token transferred to the other chain.


<center> <img src="assets/wallet.png" width=400> </center>




### 3. Implementation in general.

As the functions of the former version is included in the latter version, the latter version is explained here.

 
The following image illustrates the overview architecture. In fact, the "bridge" is a part of the server. Please carefully watch the demo now for a better understanding.

<center> <img src="assets/arc.png" width=700> </center>


1. Here I use this library [eth-lightwallet](https://github.com/ConsenSys/eth-lightwallet) to create your wallet. Your wallet is actually created and stored in your browser. Later you can use this wallet to create and sign a transaction.

2. Get some ether for test.

When you require ether in the web page, a http request will be sent to the server. On the server side, a [parity](https://wiki.parity.io/)(a ethereum client like geth) node connected to kovan testnet is running. After the server receives your request, a transaction will be sent to the node. 

3. Play the game machine and reward your token.

Every time you play 5 rounds within the game machine, a http request is sent to the server. On the server side, a private chain composed of three nodes is running. After the server receives the request, call a function in the contract and send this transaction to the chain.

4. Consume 2 tokens, you can get into a *Double* state, where in 4 rounds, your reward will double.

This part is written fully in  `js`.

5. Exchange tokens between the private chain and the public chain via the wallet.

* When you click *exchange* button, you are actually using your wallet to create and sign a transaction.
* Then the transaction, wrapped in the http request, is sent to the server. Upon receving the transaction, the server sends it to the public chain or the private chain for you according to your decision. 
* Suppose the transaction is sent to the public chain and the public chain excecutes it, reduces you token amount in the public chain, and emits an event(you can see there are event defined in the contract). 
* Our bridge, as a js program that is listening on such event will catch this event, and send another transaction to the private chain to increase your token amount in the private chain. 
* It's exactly the same process if you want to exchange your tokens to the other side.
 
 
## Appendix

* Public Chain: Kovan. We use the [Parity](https://wiki.parity.io/) client to connect to Kovan.
* Private Chain: [Geth](https://github.com/ethereum/go-ethereum), with POA as the concensus algorithm.
* API to interact with two chains: [web3js](https://web3js.readthedocs.io/en/1.0/index.html).
* Backend : [Koa](https://github.com/koajs/koa).
* Frontend: [Vue](https://vuejs.org/).
