// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract Division {
    function main(int256 x, int256 y) external pure returns (int256) {
        assembly {
            if eq(y, 0) {
                revert(0x00, 0x00)
            }
            let r := sdiv(x, y)
            mstore(0x00, r)
            return(0x00, 0x20)
            // x and y can be negative or positive
            // return x / y
            // if y == 0 revert
        }
    }
}
