// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract FizzBuzz {
    function main(uint256 num) external pure returns (string memory) {
        assembly {
            let n := calldataload(0x04)
            let p := mload(0x40)

            mstore(p, 0x20)

            if eq(mod(n, 3), 0) {
                mstore(add(p, 0x20), 0x04)
                mstore(
                    add(p, 0x40),
                    0x66697a7a00000000000000000000000000000000000000000000000000000000
                )
            }

            if eq(mod(n, 5), 0) {
                mstore(add(p, 0x20), 0x04)
                mstore(
                    add(p, 0x40),
                    0x62757a7a00000000000000000000000000000000000000000000000000000000
                )
            }

            if and(eq(mod(n, 3), 0), eq(mod(n, 5), 0)) {
                mstore(add(p, 0x20), 0x08)
                mstore(
                    add(p, 0x40),
                    0x66697a7a62757a7a000000000000000000000000000000000000000000000000
                )
            }

            return(p, add(p, 0x60))

            // if `num` is divisible by 3 return the word "fizz",
            // if divisible by 5 with the word "buzz",
            // if divisible by both 3 and 5 return the word "fizzbuzz",
            // else return an empty string "".

            // Assume `num` is greater than 0.
        }
    }
}
