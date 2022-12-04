// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

//SPDX-Licence-Identifier:MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CustomToken is ERC20 {
    constructor (string memory name ,string memory symbol) ERC20(name,symbol){
        _mint(msg.sender, 100000 *10 ** 18 );
    }
}

contract Uniswap {
    string[] public tokens =['CoinA','CoinB','CoiunC'];
    mapping ( string => ERC20) public tokenInstanceMap;
    uint ethValue = 1000000000000000;
    constructor () {
        for (uint i=0 ; i < tokens.length ;i++) {
            CustomToken token = new CustomToken (tokens[i],tokens[i] );
            tokenInstanceMap[tokens[i]]= token;
        }
    }
    function getBalance (string memory tokenname , address _address) public view returns (uint) {
        return tokenInstanceMap[tokenname].balanceOf(_address);
    }
    function getName (string memory tokenname) public view returns (string memory) {
         return tokenInstanceMap[tokenname].name();

    }
    function getTokenAddress (string memory tokenname) public view returns (address) {
         return address(tokenInstanceMap[tokenname]);

    }
    function swapEthToToken(string memory tokenname) public payable returns (uint) {
        uint inputValue=msg.value;
        uint outputValue= (inputValue / ethValue) * 10 ** 18;
        require(tokenInstanceMap[tokenname].transfer(msg.sender , outputValue));
        return outputValue;
    }
    function swapTokenToEth (string memory tokenname , uint _amount ) public  returns (uint) {
        uint exactamount = _amount /10 **18;
        uint ethToBeTransfered = exactamount * ethValue ;
        require(address(this).balance >= ethToBeTransfered ,"Dex is running low on balance");
        payable(msg.sender).transfer(ethToBeTransfered);
        require(tokenInstanceMap[tokenname].transferFrom(msg.sender , address(this),_amount));
        return ethToBeTransfered;
    }
    function swapTokenToToken(string memory  srcTokenname ,string memory desttokenname ,uint _amount ) public {
        require(tokenInstanceMap[srcTokenname].transferFrom(msg.sender , address(this),_amount));
        require(tokenInstanceMap[desttokenname].transfer(msg.sender,_amount));
    }
    function getEthBalance() public view returns (uint) {
        return address(this).balance;
    }

}
