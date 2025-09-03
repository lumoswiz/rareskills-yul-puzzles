// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 * How it works:
 *   - mask used to ensure cleanliness (i.e. don't overwrite `someValue`)
 *   - x preserves upper 128 bits only
 *   - or(...): we get both x and cleaned v allocated
 */

contract WriteToPacked128 {
    uint128 public writeHere = 1;
    uint128 public someValue = 7;

    function main(uint256 v) external {
        assembly {
            let mask := sub(shl(128, 1), 1)
            let x := shl(128, shr(128, sload(0)))
            sstore(0, or(x, and(v, mask)))

            // change the value of `writeHere` storage variable to `v`
            // be careful not to alter the value of `someValue` variable
            // Hint: storage slots are arranged sequentially. Determine the storage slot of `writeHere`
            // and use `sstore` to modify only the `writeHere` variable.
        }
    }
}
