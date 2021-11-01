// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint totalWaves;
    uint private seed;

    struct Wave{
        address waver;
        string message;
        uint timestamp;
    }

    Wave[] waves;

    event NewWave(address indexed from, uint timestamp, string message);

    mapping(address => uint) public lastWavedAt;
    
    constructor() payable{
        console.log("Hi, this is my first time");
    }

    function wave(string memory _message) public{
        require(lastWavedAt[msg.sender] + 30 seconds < block.timestamp, "wait 15m");

        lastWavedAt[msg.sender] = block.timestamp;


        totalWaves += 1;
        console.log("%s is waved!", msg.sender);
        waves.push(Wave(msg.sender, _message, block.timestamp));
        emit NewWave(msg.sender, block.timestamp, _message);

        uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);

        seed = randomNumber;

        if(randomNumber < 50){
            console.log("%s won!", msg.sender);
            // The same code we used to send the prize
            uint prizeAmount = 0.0001 ether;
            require(prizeAmount <= address(this).balance, "Trying to withdraw more money than the contract has. ");
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failes to withdraw money from contract."); 
        }

    }

    function getTotalWaves() view public returns (uint){
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }

    function getAllWaves() view public returns (Wave[] memory){
        return waves;
    }
}
