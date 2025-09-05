// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnTupleOfUint256String {
    function main() external pure returns (uint256, string memory) {
        assembly {
            let p := mload(0x40)

            mstore(p, 0x1A4)
            mstore(add(p, 0x20), 0x40)
            mstore(add(p, 0x40), 0x0a)
            mstore(
                add(p, 0x60),
                0x52617265536b696c6c7300000000000000000000000000000000000000000000
            )
            mstore(0x40, add(p, 0x80))
            return(p, 0x80)
            // return the tuple of (uint256 and string): (420, "RareSkills")
        }
    }
}
