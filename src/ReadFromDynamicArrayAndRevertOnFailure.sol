// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

/**
 * Learned:
 *   - signed integer comparisons: sgt, slt
 */

contract ReadFromDynamicArrayAndRevertOnFailure {
    uint256[] readMe;

    function setValue(uint256[] calldata x) external {
        readMe = x;
    }

    function main(int256 index) external view returns (uint256) {
        assembly {
            let l := sub(sload(0x00), 0x01)

            if or(sgt(index, l), slt(index, 0x00)) {
                mstore(0x00, shl(224, 0x4e487b71))
                mstore(0x04, 0x32)
                revert(0x00, 0x24)
            }

            let s := add(index, keccak256(0x00, 0x20))
            mstore(0x00, sload(s))
            return(0x00, 0x20)

            // read the value at the `index` in the dynamic array `readMe`
            // and return it
            // Revert with Solidity panic on failure, use error code 0x32 (out-of-bounds or negative index)
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }
}
