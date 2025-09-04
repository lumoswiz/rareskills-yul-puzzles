// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnArrayOfUint256 {
    function main(
        uint256 a,
        uint256 b,
        uint256 c
    ) external pure returns (uint256[] memory) {
        assembly {
            let p := mload(0x40)
            mstore(p, 0x20)
            mstore(add(p, 0x20), 0x03)
            mstore(add(p, 0x40), a)
            mstore(add(p, 0x60), b)
            mstore(add(p, 0x80), c)
            return(p, add(p, 0xa0))
            // return an array of [a,b,c]
        }
    }
}
