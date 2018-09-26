# Tutorial

## Overview 

This tutorial includes three part: *Deploy and Make Contract Public*, *From contract to a web app*. *Appendix*.Part one will teach you to how to deploy a contract and make it public in ethereum testnet. Part two will guide you through our demo based on this contract  and introduce how to build such a demo in general. Part three will list programming tools we use.

## Deploy and Make Contract Public

### 1. Introduction

In this part, I will guide you to deploy a contract in *Kovan* (One of ethereum testnet) and make your deployed contract public in [*Kovan Etherscan*](https://kovan.etherscan.io/). Before our start, you need to install [chrome](https://www.google.com/chrome/) and [Metamask](https://metamask.io/) extension. With *Metamask*, you dont have to run your own node. Next, we will go through guidance step by step.

### 2.  Open Metamask

After installing MetaMask,  you can find MetaMask icon(a fox) on top right. Click it. To follow our demo exactly, try the new version of *MetaMask*.


<center><img style="text-align:center" src="assets/maskopen.jpg" width="250" /></center>




### 3. Create your account 

1.After click continue, it's required to create an account for the first time. 

<center><img src="assets/newAccount.jpg" width="250" /></center>

2.After accepting several statements, you can get your "Secret Backup Phrase". Save it to a 
convenient place.  Soon we will use it to finish the creation.

> "Secret Backup Phrase" can be used to recover your account. 

<center><img src="assets/secret phrase.jpg" width="300"></center>

### Connect to Kovan Test Network

Default, we are on "Main Ethereum Network". Switch to "Kovan Test Network".


<center><img src="assets/masknetwork.jpg" width="600" /></center>

### 4. Get test ether 

For convinience, you can go to our [Demo Faucet](http://private.secdevgame.site/#/faucet) to get 0.01 ether for test. Or you can go to [Kovan faucet](https://gitter.im/kovan-testnet/faucet), send out your address and wait for administrator to give you 3 ether.

<center><img src="assets/getEther.png" width="700" /></center>



### 5.Open Remix && Connect to Kovan

1.Click [here](https://remix.ethereum.org) to open remix. 
> Remix is an online IDE for Solidity(A official programming language for smart contract). We will use it to compile and deploy our smart contract. 

2.Click *Run* on the right top and change Enviroment to "Injected Web3". As we are using *Metamask*, we connect to Kovan here.

<center><img src="assets/connectmetamask.jpg" width="400" /></center>



### 6.Compile contract 

1.For the first time, remix will generate a simple "ballot.sol" contract for us. Replace the content with our token contract. Paste our demo code to editor. You can find the code [here](https://github.com/CongGroup/SecDev2018-tutorial/blob/master/contract/DemoToken.sol)


2.Click compile. It shows the information of compiler. By default, current version is "0.4.25+commit.59dbf8f1.Emscripten.clang" and you don't need change it. In case it's different, you can choose it at the very beginning of dropdown item(show in the second picture below)

3.Select enable optimation and start compile
<center><img src="assets/compile.jpg" width="500" /> </center>

Note: Check this picture if your have trouble following step 2 in this session.
<center> <img src="assets/version.jpg", width="400"> </center>
 



### 7.Deploy Contract

After compilation, it's time to deploy the contract. Our contract constructor has four arguments:

* Amount of token to supply (uint)
* Name of token		            (string)
* Symbol of token	            (string)
* Token Decimal                   (uint). As there is no **float** type now, your may need define decimal.


Possible arguments: 10000, "DemoToken","DMT", 10

1.Input arguments and deploy.


<center><img src="assets/deploy.jpg" width="500" /></center>


2.After clicking deploy, you can see your receipt on the left of screen. Confirm it and waiting for seconds, you contract will be deployed.

<center><img src="assets/receipt.jpg" width="300" /></center>


3.After a short waiting, you can check your deployed contract. Copy the contract address. We will use it to check our contract status in "Etherscan". **Do not close remix until this part end !!**


<center><img src="assets/copyAddress.jpg" width="500" /></center>


### 8. Make your contract public in Etherscan




1.Open [Kovan Etherscan](https://kovan.etherscan.io/). Use your contract address to query your contract status. 

> In Etherscan, we can check every transaction and see the source code of every deployed contract. To make your contract reliable for others,  it's best to public your contract.

<center><img src="assets/getEther.png" width="800" /></center>




2.At this moment, you can only see your contract bytecode or opcode. Then click "Verify and Publish" to offer your source code.

<center><img src="assets/eccode.jpg" width="800" /></center>


3.Input your contract name , choose compiler version,  soruce code. Then you can verify and publish your source code.


<center><img src="assets/publish.jpg" width="800" /></center>



4.Now your source code is viewable for everyone.


<center><img src="assets/sourceCode.jpg" width="800" /></center>


## From contract to a web app

### 1. Introduction

In this part, I will guide you to go through our demo. We have two version of demo, one is built on public chain, the other is built on private chain and public chain. The function of the former version is included in the latter version. While after experiencing the former version, you can have a better view abount why we use private chain here. 

Former version is [here](http://public.secdevgame.site), which is built on public chain

The latter version is [here](http://private.secdevgame.site), which is built on private chain and public chain.

After go through our demo, I will introduce what is needed to implement such a demo in general.

### 2. Demo Show
(这部分我等会优化下前端再补充图片)


1.Create your account and log in.

2.Get some ether for test

3.Now you can start to play game machine! Input your bet amount and run slotmachine. 5 rounds you will get one token for reward.

4.Consume 2 tokens, you can get into a *Double* state, where in 4 rounds, your reward will be doubled.

5.(This part is only showed in the latter version) Look into wallet, you can transfer your token between our private chain and our public chain. After input amount of token to transfer, click *exchange* button and input your password, you will send a transaction signed by your account to our server. Our server will send this signed transaction to public or private chain.


### 3. Implementation in general.

As the function of the former version is included in the latter version, I only introduce the latter version here.

 
Following picture is the overview architecture. In fact, bridge is a part of server.  I list it as a seperate part for its sepecial meaning. Now let us review our demo and see what actually happended in behind. Then the meaing of this picture will be clear. In the end, I will list programming tools to build this demo.

<center> <img src="assets/arc.png" width=700> </center>


1.Create your account and login in.

Here use [eth-lightwallet](https://github.com/ConsenSys/eth-lightwallet) to create your wallet. Your wallet is actually created and stored in your browser. Later you can use this wallet to create and sign a transaction.

2.Get some ether for test.

When you require ether in the web page, a http request will send to our server.  In our server side, a [parity](https://wiki.parity.io/)(a ethereum client like geth) node connected to kovan testnet is running. After our server receive your request, we will create a transfer transaction and send it to our node. 

3.Play game machine and reward your token.

The game machine is just a `js` stuff. Every time you play 5 rounds,  a http request is sent to our server. In our server side, a private chain composed of three node is running. After our server receive the request, we will call a function in our contract and send this transaction to the chain.

4.Consume 2 tokens, you can get into a *Double* state, where in 4 rounds, your reward will be doubled.

This step is completely implemented by `js`.

5.Exchange tokens between private chain and public chain in wallet.

* When you click *exchange* button, you use your wallet to create a transaction and use your input password to sign the transaction. 
* Then the transaction is contained in http request send to our server. Our server send this transaction to public chain or private chain for you according to your choice. 
* Suppose the transaction is sent to public chain and the public chain excecutes it, reduces you token amount in the public chain, and emits an event(you can see there are event defined in our contract). 
* Our bridge, a js program that is listening on such an event will catch this event, and send another transaction to the private chain to increase your token amount in the private chain. 
* It's totally the same process if you want to exchange your tokens to the other side.
 
 
## Appendix

* Public Chain: Kovan. We use [Parity](https://wiki.parity.io/) client to connect to Kovan.
* Private Chain: [Geth](https://github.com/ethereum/go-ethereum), with POA as concensus algorithm
* API to interact with two chain: [web3js](https://web3js.readthedocs.io/en/1.0/index.html)
* Backend : [Koa](https://github.com/koajs/koa)
* Frontend: [Vue](https://vuejs.org/)
