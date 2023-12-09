// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    uint256 public constant NEW_VALUE = 7;
    DeployBox deployer;
    UpgradeBox upgrader;

    address public OWNER = makeAddr("OWNER");
    address public proxy;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); //! right now, points to BoxV1
    }

    function test_Upgrades() public {
        //1 Arrange
        BoxV2 boxV2 = new BoxV2();
        uint256 expectedValue = 2;
        //2 Act
        upgrader.upgradeBox(proxy, address(boxV2));
        //3 Assert
        assertEq(expectedValue, BoxV2(proxy).version());
    }

    function test_ProxyStartsAsBoxV1() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(NEW_VALUE);
    }
}
