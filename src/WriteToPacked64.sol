// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToPacked64 {
    uint64 public someValue1 = 7;
    uint64 public writeHere = 1;
    uint64 public someValue2 = 7;
    uint64 public someValue3 = 7;

    function main(uint256 v) external {
        assembly {
            let m := sub(shl(64, 1), 1)
            let mask := shl(64, m)
            let c := and(sload(0), not(mask))
            let pv := shl(64, and(v, m))
            sstore(0, or(c, pv))

            // change the value of `writeHere` storage variable to `v`
            // be careful not to alter the value of `someValue` variable
        }
    }
}
