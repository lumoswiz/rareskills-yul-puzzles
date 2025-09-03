// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.13;

contract WriteToDynamicArray {
    uint256[] writeHere;

    function main(uint256[] memory x) external {
        assembly {
            let h := 0x04
            let o := calldataload(h)
            let d := add(h, o)
            let l := calldataload(d)
            let p := add(d, 0x20)

            let s := keccak256(0x00, 0x20)
            // prettier-ignore
            for { let i := 0} lt(i, l) { i := add(i, 0x01)} {   
                sstore(s, calldataload(p))
                s := add(s, 0x01)
                p := add(p, 0x20)
            }
            sstore(0x00, l)
            // store the values in the DYNAMIC array `x` in the storage variable `writeHere`
            // Hint: https://www.rareskills.io/post/solidity-dynamic
        }
    }

    function getter() external view returns (uint256[] memory) {
        return writeHere;
    }
}
