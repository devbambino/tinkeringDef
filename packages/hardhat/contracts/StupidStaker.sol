//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";

contract StupidStaker {
	
	//address public theBurner = 0xcA3895d1835641e94a45D3f386aB99d269F33814;

	mapping(address => uint64) public whenStaked;
	function stake() public payable {
		//console.log("Staking %s", msg.value);
		require(msg.value == 0.01 ether,"put at leat 0.01 ether!");
		//console.log("user time %s", whenStaked[msg.sender]);
		require(whenStaked[msg.sender] == 0 ,"You have alredy staked!");
		whenStaked[msg.sender] = uint64(block.timestamp);
		//console.log("Staker time %s", whenStaked[msg.sender]);
	}

	function timeStaked(address staker) public view returns (uint64){
		return uint64(block.timestamp) - whenStaked[staker];

	}
	function withdraw() public{
		require(whenStaked[msg.sender] > 0,"You are no staker");
		require(timeStaked(msg.sender) > 30 seconds,"wait at least 30 s");
		
		uint256 totalPayback = 0.01 ether;
		if(prizePool >= 0.001 ether){
			totalPayback += 0.001 ether;
			prizePool -= 0.001 ether;
		}

		payable(msg.sender).transfer(totalPayback);
		whenStaked[msg.sender] = 0;
	}

	uint256 public prizePool = 0;
	/**
     * Function that allows the contract to receive ETH
     */
    receive() external payable {
    	prizePool += msg.value;
    }
}