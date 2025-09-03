// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteTwoDynamicArraysToStorage {
    uint256[] public writeHere1;
    uint256[] public writeHere2;

    function main(uint256[] calldata x, uint256[] calldata y) external {
        assembly {
            let px := keccak256(0x00, 0x20)
            mstore(0x00, 0x01)
            let py := keccak256(0x00, 0x20)

            calldatacopy(0x00, 0x04, sub(calldatasize(), 0x04))

            let ox := mload(0x00)
            let oy := mload(0x20)

            let lx := mload(ox)
            let ly := mload(oy)

            sstore(0x00, lx)
            sstore(0x01, ly)

            let dx := add(ox, 0x20)
            // prettier-ignore
            for { let i := 0 } lt(i, lx) { i := add(i, 1) } {
                sstore(add(px, i), mload(add(dx, mul(i, 0x20))))
            }

            let dy := add(oy, 0x20)
            // prettier-ignore
            for { let j := 0} lt(j, ly) { j := add(j, 1)} {
                sstore(add(py, j), mload(add(dy, mul(j, 0x20))))
            }
            // write the dynamic calldata array `x` to storage variable `writeHere1` and
            // dynamic calldata array `y` to storage variable `writeHere2`
        }
    }
}
