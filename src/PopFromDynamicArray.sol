// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract PopFromDynamicArray {
    uint256[] popFromMe = [23, 4, 19, 3, 44, 88];

    function main() external {
        assembly {
            let s := add(0x05, keccak256(0x00, 0x20))
            let v := sload(s)

            sstore(s, 0x00)
            sstore(0x00, 0x05)
            // pop the last element from the dynamic array `popFromMe`
            // dont forget to clean the popped element's slot.
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }

    function getter() external view returns (uint256[] memory) {
        return popFromMe;
    }

    function lastElementSlotValue(bytes32 s) external view returns (uint256 r) {
        assembly {
            r := sload(s)
        }
    }
}
