// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfString {
    function main() external pure returns (string memory, string memory) {
        assembly {
            let p := mload(0x40)

            mstore(p, 0x40) // A offset
            mstore(add(p, 0x20), 0x80) // B offset
            mstore(add(p, 0x40), 0x05)
            mstore(
                add(p, 0x60),
                0x48656c6c6f000000000000000000000000000000000000000000000000000000
            )
            mstore(add(p, 0x80), 0x0a)
            mstore(
                add(p, 0xa0),
                0x52617265536b696c6c7300000000000000000000000000000000000000000000
            )
            return(p, add(p, 0xc0))

            // return the tuple of string: ("Hello", "RareSkills")
        }
    }
}
