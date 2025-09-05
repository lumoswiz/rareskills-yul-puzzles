// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnSimpleStruct {
    // STRUCT
    struct Point {
        uint256 x;
        uint256 y;
    }

    function main(uint256 x, uint256 y) external pure returns (Point memory) {
        assembly {
            let p := mload(0x40)

            mstore(p, calldataload(0x04))
            mstore(add(p, 0x20), calldataload(0x24))
            return(p, 0x40)
            // return the struct: `Point{x,y}`
        }
    }
}
