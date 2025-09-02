// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract MaxOfArray {
    function main(uint256[] memory arr) external pure returns (uint256) {
        assembly {
            let offset := calldataload(0x04)
            let length := calldataload(add(0x04, offset))

            if eq(0x00, length) {
                revert(0x00, 0x00)
            }

            let p := add(0x24, offset)
            let end := add(p, mul(length, 0x20))

            let max := calldataload(p)
            p := add(p, 0x20)

            // prettier-ignore
            for { } lt(p, end) { p := add(p, 0x20) } {
                let v := calldataload(p)
                if gt(v, max) {
                    max := v
                }
            }

            mstore(0x00, max)
            return(0x00, 0x20)

            // return the maximum value in the array
            // revert if array is empty
        }
    }
}
