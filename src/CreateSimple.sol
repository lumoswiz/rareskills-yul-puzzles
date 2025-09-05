// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimple {
    function main(
        bytes memory deploymentBytecode
    ) external returns (address addr) {
        assembly {
            addr := create(
                0,
                add(deploymentBytecode, 0x20),
                mload(deploymentBytecode)
            )
            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: the bytecode is already in memory
        }
    }
}
