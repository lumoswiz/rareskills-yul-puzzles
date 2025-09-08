// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 * Initial implementation: linear-scan over bit width
 * Checked solady, which inspired this current impl. Ref:
 * https://github.com/Vectorized/solady/blob/main/src/utils/FixedPointMathLib.sol#L921
 */

contract Log2 {
    function main(uint256 x) external pure returns (uint256 r) {
        assembly {
            if iszero(x) {
                revert(0, 0)
            }

            let y := x

            if gt(y, 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF) {
                y := shr(128, y)
                r := add(r, 128)
            }

            if gt(y, 0xFFFFFFFFFFFFFFFF) {
                y := shr(64, y)
                r := add(r, 64)
            }

            if gt(y, 0xFFFFFFFF) {
                y := shr(32, y)
                r := add(r, 32)
            }

            if gt(y, 0xFFFF) {
                y := shr(16, y)
                r := add(r, 16)
            }

            if gt(y, 0xFF) {
                y := shr(8, y)
                r := add(r, 8)
            }

            if gt(y, 0xF) {
                y := shr(4, y)
                r := add(r, 4)
            }

            if gt(y, 0x3) {
                y := shr(2, y)
                r := add(r, 2)
            }

            if gt(y, 0x1) {
                r := add(r, 1)
            }
        }
    }
}
