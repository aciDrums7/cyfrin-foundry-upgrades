// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {ChallengeThirteen} from "../../src/challenge/ChallengeThirteen.sol";
import {ChallengeThirteenSolver} from "../../src/challenge/ChallengeThirteenSolver.sol";

contract ChallengeThirteenTest is Test {
    ChallengeThirteen challenge;
    ChallengeThirteenSolver solver;

    address USER = makeAddr("USER");

    function setUp() public {
        vm.startPrank(USER);
        challenge = new ChallengeThirteen();
        solver = new ChallengeThirteenSolver();
        vm.stopPrank();
    }

    function test_SolveChallengeThirteen( /* int256 _solution */ ) public {
        vm.startPrank(USER);
        // solver.setNumber(_solution);
        vm.expectRevert();
        challenge.solveChallenge(address(solver));
        vm.stopPrank();
    }
}
