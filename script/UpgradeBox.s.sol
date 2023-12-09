// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Script} from "forge-std/Script.sol";
import {BoxV2} from "../src/BoxV2.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract UpgradeBox is Script {
    function run() external returns (address) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        BoxV2 newBox = new BoxV2();
        vm.stopBroadcast();
        address proxy = upgradeBox(mostRecentlyDeployed, address(newBox));
        return proxy;
    }

    function upgradeBox(address proxyAddress, address newImpl) public returns (address) {
        vm.startBroadcast();
        BoxV1 proxy = BoxV1(proxyAddress);
        //? ERC1967Proxy and UUPSUpgradeable contracts refer to ERC1967Utils library to get and set contract proxy implementations.
        proxy.upgradeToAndCall(newImpl, new bytes(0)); // proxy contract now points to this new address
        vm.stopBroadcast();
        return address(proxy);
    }
}
