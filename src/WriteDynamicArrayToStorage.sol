// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteDynamicArrayToStorage {
    uint256[] public writeHere;

    function main(uint256[] calldata x) external {
        assembly {
            let ptr := keccak256(0x00, 0x20)

            calldatacopy(0x00, 0x04, sub(calldatasize(), 0x04))
            let off := mload(0x00)
            let len := mload(off)
            sstore(0x00, len)

            let data := add(off, 0x20)
            // prettier-ignore
            for {let i := 0} lt(i, len) {i := add(i, 1)} {
                sstore(ptr, mload(data))
                ptr := add(ptr, 1)
                data := add(data, 0x20)
            }
            // write the dynamic calldata array `x` to storage variable `writeHere`
        }
    }
}
