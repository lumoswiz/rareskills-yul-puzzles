// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 * Cool tricks:
 *   - let v := calldataload(add(0x04, shl(5, k)))
 *   - if iszero(iszero(lane)) {...}, only sload if needed
 *   - and(word, not(lm)), wipes lane clean
 *   - shl(lo, and(v, m)), truncates to 64 bits i.e. cleaned
 *
 * Process for overlaying two bitfields
 *   - clear old bits
 *   - prepare new bits
 *   - combine with `or`
 *
 * shr(n, x) -> x/(2^n)
 * shl(n, x) -> x * 2^n
 * and(x, sub(shl(n, 1), 1)) -> x mod 2^n
 */

contract WriteToPackedDynamicArray64 {
    uint64[] public writeHere;

    function main(
        uint64 v1,
        uint64 v2,
        uint64 v3,
        uint64 v4,
        uint64 v5
    ) external {
        assembly {
            let len := sload(0x00)
            let idx := shr(2, len)
            let lane := and(len, 3)

            let ptr := keccak256(0x00, 0x20)
            let slot := add(ptr, idx)

            let word := 0
            if iszero(iszero(lane)) {
                word := sload(slot)
            }

            let m := sub(shl(64, 1), 1)
            // prettier-ignore
            for { let k := 0 } lt(k, 5) { k := add(k, 1) } {
                let v := calldataload(add(0x04, shl(5, k)))
                let lo := shl(6, lane)
                let lm := shl(lo, m)
                word := or(and(word, not(lm)), shl(lo, and(v, m)))

                lane := add(lane, 1)
                if eq(lane, 4) {
                    sstore(slot, word)
                    slot := add(slot, 1)
                    word := 0
                    lane := 0
                }
            }

            if gt(lane, 0) {
                sstore(slot, word)
            }

            sstore(0x00, add(len, 5))

            // write the code to store v1, v2, v3, v4, and v5 in the `writeHere` array in sequential order.
            // Hint: `writeHere` is a dynamic array, so you will need to access its length and use `mstore` or `sstore`
            // appropriately to push new values into the array.
        }
    }
}
