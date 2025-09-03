// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToFixedArray {
    uint256[5] writeHere;

    function main(uint256[5] memory x) external {
        assembly {
            sstore(0x00, calldataload(0x04))
            sstore(0x01, calldataload(0x24))
            sstore(0x02, calldataload(0x44))
            sstore(0x03, calldataload(0x64))
            sstore(0x04, calldataload(0x84))
            // store the values in the fixed array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }

    function getter() external view returns (uint256[5] memory) {
        return writeHere;
    }
}
