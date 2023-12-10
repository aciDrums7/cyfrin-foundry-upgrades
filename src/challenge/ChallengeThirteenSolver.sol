// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ChallengeThirteenSolver {
    address private immutable i_owner;
    // int256 private number;

    constructor() {
        i_owner = msg.sender;
    }

    function owner() external view returns (address) {
        return i_owner;
    }

    function getNumber() external pure returns (int256) {
        return -572038313094850821099624258919152072749626291038;
        //1 why this strange number? Storage slot 0 of challenge contract is an address (use cast to check it)
        //2 but in the helper conctract it's an int256, so if you force convert that hex address to a number and include it in the Helper::addTen()
        //3 you have the solution!
    }

    /*  function setNumber(int256 _number) external {
        number = _number;
    } */
}
