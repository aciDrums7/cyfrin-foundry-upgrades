// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {ChallengeThirteenHelper} from "./ChallengeThirteenHelper.sol";
import {console} from "forge-std/console.sol";

interface YourContract {
    function owner() external view returns (address);
    function getNumber() external view returns (int256);
}

contract ChallengeThirteen {
    error ChallengeThirteen__NotSolved();

    string private constant LESSON_IMAGE = "ipfs://QmdHgyTYLg3hpjMdf6D9nE7Udwubxk2WvmJtv2KewCd6KM"; // TODO
    uint256 private constant TARGET_NUMBER = 1337;
    uint256 private LESSON_VERSION = 2;
    uint256 private COURSE_VERSION = 3;

    ChallengeThirteenHelper private immutable i_helperContract;

    constructor() {
        i_helperContract = new ChallengeThirteenHelper();
    }

    /*
     * CALL THIS FUNCTION!
     * 
     * @param yourContract = the contract you're using to solve this
     * @param yourTwitterHandle - Your twitter handle. Can be a blank string.
     */
    function solveChallenge(address yourContract) external returns (bool) {
        YourContract yc = YourContract(yourContract);
        int256 number = yc.getNumber();
        address yourOwner = yc.owner();

        if (yourOwner != msg.sender) {
            console.log(yourOwner);
            console.log(msg.sender);
            revert ChallengeThirteen__NotSolved();
        }

        (bool success, bytes memory data) =
            address(i_helperContract).delegatecall(abi.encodeWithSignature("addTen(int256)", number));

        if (!success) {
            console.log("call failed");
            revert ChallengeThirteen__NotSolved();
        }
        uint256 result = abi.decode(data, (uint256));

        if (result != TARGET_NUMBER) {
            console.log(result);
            console.log(TARGET_NUMBER);
            revert ChallengeThirteen__NotSolved();
        }
        console.log("solved");
        return true;
    }
}
