// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnString {
    function main() external pure returns (string memory) {
        assembly {
            let p := mload(0x40)

            mstore(p, 0x20)
            mstore(add(p, 0x20), 17)
            mstore(
                add(p, 0x40),
                0x48656c6c6f2c2052617265536b696c6c73000000000000000000000000000000
            )
            return(p, 0x60)
            // return the exact string: `Hello, RareSkills`
        }
    }
}
