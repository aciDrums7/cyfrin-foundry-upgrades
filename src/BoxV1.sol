// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract BoxV1 is UUPSUpgradeable {
    uint256 internal number;

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    /**
     *
     * @param newImplementation The new implementation address
     * @notice IF NOT IMPLEMENTED, MEANS ANYONE CAN AUTHORIZE AN UPGRADE
     */
    function _authorizeUpgrade(address newImplementation) internal override {}
}
