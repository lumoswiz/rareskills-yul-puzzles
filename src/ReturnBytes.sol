// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract ReturnBytes {
    function main(address a, uint256 b) external pure returns (bytes memory) {
        assembly {
            let p := mload(0x40)
            mstore(p, 0x20)
            mstore(add(p, 0x20), 0x40)
            mstore(add(p, 0x40), a)
            mstore(add(p, 0x60), b)
            mstore(0x40, add(p, 0x80))
            return(p, 0x80)
            // encode a and b `abi.encode(a,b)` and return it.
        }
    }
}
