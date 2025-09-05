// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract CreateSimpleCalldata {
    function main(
        bytes calldata deploymentBytecode
    ) external returns (address) {
        assembly {
            let off := calldataload(0x04)
            let ptr := add(0x04, off)
            let len := calldataload(ptr)
            let dbc := add(ptr, 0x20)

            let p := mload(0x40)
            calldatacopy(p, dbc, len)

            let addr := create(0, p, len)

            mstore(0x00, addr)
            return(0x00, 0x20)

            // create a contract using the deploymentBytecode
            // return the address of the contract
            // hint: use the `create` opcode
            // hint: use calldatacopy to copy the deploymentBytecode to memory
        }
    }
}
