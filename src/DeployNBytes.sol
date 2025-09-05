// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract DeployNBytes {
    function main(uint256 size) external returns (address) {
        assembly {
            let initBase := 0x6001600c60403960016040f3

            let s := and(size, 0xff)
            let mask := or(shl(80, 0xff), shl(24, 0xff))

            let initClean := and(initBase, not(mask))
            let sInj := or(shl(80, s), shl(24, s))
            let init := or(initClean, sInj)

            let p := mload(0x40)
            mstore(p, init)

            let initPtr := add(p, sub(32, 12))
            let rtPtr := add(initPtr, 12)

            // prettier-ignore
            for { let i := 0} lt(i, size) { i := add(i, 1) } {
                mstore8(add(rtPtr, i), 0xff)
            }

            let len := add(12, size)
            let addr := create(0, initPtr, len)
            mstore(0x00, addr)
            return(0x00, 0x20)

            // create a contract that is size bytes long
            // hint: you will need to generalize the init code of DeployOneByte
            // hint: use mstore8 to target a single byte
            // hint: because we only care about the size, you can simply return that region
            //       of memory and not care about what is inside it
        }
    }
}
