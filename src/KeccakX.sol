// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract KeccakX {
    function main(uint256 x) external pure returns (bytes32) {
        assembly {
            mstore(0x00, x)
            mstore(0x00, keccak256(0x00, 0x20)) // overwriting x in memory
            return(0x00, 0x20)
            // return the keccak hash of x
            // Hint: use keccak256(offset, size)
            // Hint: you need to put x in memory first
        }
    }
}
