// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

contract BoxV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    uint256 internal number;

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
        // owner = msg.sender
    }

    /**
     * @notice initialize is like constructor for proxy
     */
    function initialize() public initializer {
        // whatever logic needed
        //! will modify the proxy contract's storage
        __Ownable_init(msg.sender); //? sets owner to param
        __UUPSUpgradeable_init();
    }

    function setNumber(uint256 _number) external {}

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
