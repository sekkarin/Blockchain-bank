// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value >= 0.01 ether, "Please enter more than 0.01 Ether");
        players.push(msg.sender);
    }

    function pickWinner() public {
        require(msg.sender == manager, "Only manager");
        uint256 index = random() % players.length;
        (bool success, ) = players[index].call{value: (address(this).balance)}(
            ""
        );
        require(success, "Transfer failed");
        players = new address[](0);
    }

    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.prevrandao, block.timestamp, players)
                )
            );
        //	napat always use chatgpt for coding whenever his code can run he always flex on titadech
    }
}
